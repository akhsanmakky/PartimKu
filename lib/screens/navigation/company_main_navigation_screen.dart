import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../company/company_dashboard_screen.dart';
import '../company/company_applicants_screen.dart';
import '../company/company_chat_list_screen.dart';
import '../company/company_profile_screen.dart';

class CompanyMainNavigationScreen extends StatefulWidget {
  const CompanyMainNavigationScreen({super.key});

  @override
  _CompanyMainNavigationScreenState createState() => _CompanyMainNavigationScreenState();
}

class _CompanyMainNavigationScreenState extends State<CompanyMainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CompanyDashboardScreen(),
    CompanyApplicantsScreen(),
    CompanyChatListScreen(),
    CompanyProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(Icons.dashboard_outlined),
            activeIcon: const Icon(Icons.dashboard_rounded),
            title: const Text('Lowongan'),
            selectedColor: const Color(0xFF4F46E5),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.people_outline_rounded),
            activeIcon: const Icon(Icons.people_rounded),
            title: const Text('Pelamar'),
            selectedColor: const Color(0xFF4F46E5),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.chat_bubble_outline_rounded),
            activeIcon: const Icon(Icons.chat_bubble_rounded),
            title: const Text('Chat'),
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
