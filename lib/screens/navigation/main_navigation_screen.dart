
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../services/api_service.dart';
import '../user/home_screen.dart';
import '../user/application_status_screen.dart';
import '../user/edit_profile_screen.dart';
import '../user/job_history_screen.dart';
import 'company_main_navigation_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ApplicationStatusScreen(),
    ProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }

@override
  Widget build(BuildContext context) {
    final role = ApiService().currentUserRole;
    if (role == 'company') {
      return CompanyMainNavigationScreen();
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        selectedItemColor: const Color(0xFF4F46E5),
        unselectedItemColor: Colors.grey[400],
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.work_outline_rounded),
            activeIcon: const Icon(Icons.work_rounded),
            title: const Text('Lowongan'),
            selectedColor: const Color(0xFF4F46E5),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.assignment_outlined),
            activeIcon: const Icon(Icons.assignment_rounded),
            title: const Text('Lamaran'),
            selectedColor: const Color(0xFF4F46E5),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outline_rounded),
            activeIcon: const Icon(Icons.person_rounded),
            title: const Text('Profil'),
            selectedColor: const Color(0xFF4F46E5),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _apiService = ApiService();

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = _apiService.getCurrentUser();
    final applications = _apiService.getApplications();
    final history = _apiService.getJobHistory();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [

          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                  child: Column(
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.4), width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          child: Text(
                            user.name.isNotEmpty ? user.name.substring(0, 1).toUpperCase() : 'U',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4F46E5),
                            ),
                          ),
                        ),
                      )
                          .animate()
                          .scale(duration: 600.ms, curve: Curves.easeOutBack),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 500.ms),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 300.ms, duration: 500.ms),
                      if (user.bio.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            user.bio,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.9),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 400.ms, duration: 500.ms),
                      ],
                      if (user.phone.isNotEmpty || user.location.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          alignment: WrapAlignment.center,
                          children: [
                            if (user.phone.isNotEmpty)
                              _buildInfoChip(
                                icon: Icons.phone_outlined,
                                label: user.phone,
                              ),
                            if (user.location.isNotEmpty)
                              _buildInfoChip(
                                icon: Icons.location_on_outlined,
                                label: user.location,
                              ),
                          ],
                        )
                            .animate()
                            .fadeIn(delay: 450.ms, duration: 500.ms),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.assignment_outlined,
                      value: '${applications.length}',
                      label: 'Lamaran',
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.check_circle_outlined,
                      value: '${history.where((h) => h.status == 'completed').length}',
                      label: 'Selesai',
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.timelapse_outlined,
                      value: '${history.where((h) => h.status == 'ongoing').length}',
                      label: 'Berjalan',
                      color: Colors.orange,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, duration: 600.ms),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.edit_outlined,
                    title: 'Edit Profil',
                    subtitle: 'Perbarui informasi pribadi',
                    color: const Color(0xFF4F46E5),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditProfileScreen()),
                      ).then((result) {
                        if (result == true) _refresh();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildMenuItem(
                    icon: Icons.work_history_outlined,
                    title: 'Riwayat Pekerjaan',
                    subtitle: 'Lihat pekerjaan yang pernah dilamar',
                    color: Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => JobHistoryScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Pengaturan',
                    subtitle: 'Atur preferensi aplikasi',
                    color: Colors.grey[700]!,
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  _buildMenuItem(
                    icon: Icons.help_outline_rounded,
                    title: 'Bantuan',
                    subtitle: 'Pusat bantuan dan FAQ',
                    color: Colors.amber[700]!,
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                      label: const Text(
                        'Keluar',
                        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.redAccent.withOpacity(0.3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.redAccent.withOpacity(0.05),
                      ),
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0, duration: 600.ms),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white.withOpacity(0.9)),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

