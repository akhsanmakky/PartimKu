import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final companyNameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  String _selectedRole = 'jobseeker';

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final companyName = companyNameController.text.trim();
      ApiService().setCurrentUserFromLogin(
        email: email,
        name: name,
        role: _selectedRole,
        companyName: _selectedRole == 'company' ? companyName : null,
      );

      setState(() => _isLoading = false);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Pendaftaran berhasil! Silakan login."),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    companyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF4F46E5),
                      Color(0xFF7C3AED),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -40,
                      right: -40,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: -30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 40, 28, 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            "Buat Akun",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 100.ms, duration: 600.ms)
                              .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut),
                          const SizedBox(height: 8),
                          Text(
                            "Daftar untuk mulai mencari pekerjaan part time impianmu",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.85),
                              height: 1.5,
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 250.ms, duration: 600.ms)
                              .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Nama Lengkap")
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 500.ms),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Nama tidak boleh kosong'
                            : null,
                        decoration: InputDecoration(
                          hintText: "aksa",
                          prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.grey[500]),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 350.ms, duration: 500.ms)
                          .slideY(begin: 0.2, end: 0, duration: 500.ms),
                      const SizedBox(height: 20),

                      _buildLabel("Daftar Sebagai")
                          .animate()
                          .fadeIn(delay: 380.ms, duration: 500.ms),
                      const SizedBox(height: 8),
                      _buildRoleToggle()
                          .animate()
                          .fadeIn(delay: 390.ms, duration: 500.ms)
                          .slideY(begin: 0.2, end: 0, duration: 500.ms),
                      const SizedBox(height: 20),

                      _buildLabel("Email")
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 500.ms),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
                          if (!value.contains('@')) return 'Masukkan email yang valid';
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "nama@email.com",
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[500]),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 450.ms, duration: 500.ms)
                          .slideY(begin: 0.2, end: 0, duration: 500.ms),
                      const SizedBox(height: 20),

                      if (_selectedRole == 'company') ...[
                        _buildLabel("Nama Perusahaan")
                            .animate()
                            .fadeIn(delay: 460.ms, duration: 500.ms),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: companyNameController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (_selectedRole == 'company' && (value == null || value.isEmpty)) {
                              return 'Nama perusahaan tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Contoh: PT Maju Jaya",
                            prefixIcon: Icon(Icons.business_outlined, color: Colors.grey[500]),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 470.ms, duration: 500.ms)
                            .slideY(begin: 0.2, end: 0, duration: 500.ms),
                        const SizedBox(height: 20),
                      ],

                      _buildLabel("Password")
                          .animate()
                          .fadeIn(delay: 500.ms, duration: 500.ms),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
                          if (value.length < 6) return 'Password minimal 6 karakter';
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "••••••••",
                          prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey[500]),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey[500],
                            ),
                            onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 550.ms, duration: 500.ms)
                          .slideY(begin: 0.2, end: 0, duration: 500.ms),
                      const SizedBox(height: 20),

                      _buildLabel("Konfirmasi Password")
                          .animate()
                          .fadeIn(delay: 600.ms, duration: 500.ms),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _register(),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Konfirmasi password tidak boleh kosong';
                          if (value != passwordController.text) return 'Password tidak cocok';
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "••••••••",
                          prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey[500]),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey[500],
                            ),
                            onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 650.ms, duration: 500.ms)
                          .slideY(begin: 0.2, end: 0, duration: 500.ms),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F46E5),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text("Daftar"),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 700.ms, duration: 500.ms)
                          .slideY(begin: 0.2, end: 0, duration: 500.ms),
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey[300])),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "atau daftar dengan",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey[300])),
                        ],
                      )
                          .animate()
                          .fadeIn(delay: 750.ms, duration: 500.ms),
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: _buildSocialButton(
                              icon: Icons.g_mobiledata_rounded,
                              label: "Google",
                              color: Colors.redAccent,
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSocialButton(
                              icon: Icons.apple,
                              label: "Apple",
                              color: Colors.black87,
                              onTap: () {},
                            ),
                          ),
                        ],
                      )
                          .animate()
                          .fadeIn(delay: 800.ms, duration: 500.ms),
                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sudah punya akun? ",
                            style: TextStyle(color: Colors.grey[600], fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xFF4F46E5),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )
                          .animate()
                          .fadeIn(delay: 850.ms, duration: 500.ms),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildRoleToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedRole = 'jobseeker'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedRole == 'jobseeker' ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _selectedRole == 'jobseeker'
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 18,
                      color: _selectedRole == 'jobseeker' ? const Color(0xFF4F46E5) : Colors.grey[500],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Pencari Kerja',
                      style: TextStyle(
                        fontWeight: _selectedRole == 'jobseeker' ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                        color: _selectedRole == 'jobseeker' ? const Color(0xFF4F46E5) : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedRole = 'company'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedRole == 'company' ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _selectedRole == 'company'
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.business_outlined,
                      size: 18,
                      color: _selectedRole == 'company' ? const Color(0xFF4F46E5) : Colors.grey[500],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Perusahaan',
                      style: TextStyle(
                        fontWeight: _selectedRole == 'company' ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                        color: _selectedRole == 'company' ? const Color(0xFF4F46E5) : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

