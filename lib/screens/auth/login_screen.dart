import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../services/api_service.dart';
import '../navigation/main_navigation_screen.dart';
import '../navigation/company_main_navigation_screen.dart';
import 'register_screen.dart';
import 'registration_admin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String _selectedRole = 'jobseeker';

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      final email = emailController.text.trim();
      ApiService().setCurrentUserFromLogin(
        email: email,
        role: _selectedRole,
      );

      setState(() => _isLoading = false);

      if (_selectedRole == 'company') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => CompanyMainNavigationScreen()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => MainNavigationScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
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
                      padding: const EdgeInsets.fromLTRB(28, 32, 28, 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Center(
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/logo.jpg',
                                  width: 72,
                                  height: 72,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 50.ms, duration: 600.ms)
                              .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0), duration: 600.ms, curve: Curves.easeOutBack),
                          const SizedBox(height: 20),
                          const Text(
                            "Selamat Datang",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 150.ms, duration: 600.ms)
                              .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut),
                          const SizedBox(height: 8),
                          Text(
                            "Login untuk melanjutkan mencari pekerjaan part time impianmu",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
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
                      _buildLabel("Daftar Sebagai")
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 500.ms),
                      const SizedBox(height: 8),
                      _buildRoleToggle()
                          .animate()
                          .fadeIn(delay: 350.ms, duration: 500.ms)
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

                      _buildLabel("Password")
                          .animate()
                          .fadeIn(delay: 500.ms, duration: 500.ms),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _login(),
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
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
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
                              : const Text("Login"),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 600.ms, duration: 500.ms)
                          .slideY(begin: 0.2, end: 0, duration: 500.ms),
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey[300])),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "atau",
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
                          .fadeIn(delay: 650.ms, duration: 500.ms),
                      const SizedBox(height: 24),

                      _buildRegisterOption(
                        label: "Belum punya akun? ",
                        action: "Daftar",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 700.ms, duration: 500.ms),
                      const SizedBox(height: 12),
                      _buildRegisterOption(
                        label: "Daftarkan perusahaan? ",
                        action: "Daftar Admin",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RegistrationAdminScreen()),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 750.ms, duration: 500.ms),
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

  Widget _buildRegisterOption({
    required String label,
    required String action,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            action,
            style: const TextStyle(
              color: Color(0xFF4F46E5),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

