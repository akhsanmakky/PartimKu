import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/application.dart';
import '../../services/api_service.dart';
import 'company_applicant_detail_screen.dart';

class CompanyApplicantsScreen extends StatefulWidget {
  const CompanyApplicantsScreen({super.key});

  @override
  _CompanyApplicantsScreenState createState() => _CompanyApplicantsScreenState();
}

class _CompanyApplicantsScreenState extends State<CompanyApplicantsScreen> {
  final ApiService _apiService = ApiService();

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = _apiService.getCurrentUser();
    final applicants = _apiService.getApplicantsForCompany(user.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Data Pelamar'),
        elevation: 0,
      ),
      body: applicants.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text('Belum ada pelamar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: applicants.length,
              itemBuilder: (context, index) {
                final app = applicants[index];
                return _buildApplicantCard(app)
                    .animate()
                    .fadeIn(delay: (index * 100).ms, duration: 500.ms)
                    .slideY(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOut);
              },
            ),
    );
  }

  Widget _buildApplicantCard(Application app) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CompanyApplicantDetailScreen(
              jobId: app.jobId,
              jobTitle: app.jobTitle,
              initialApplicationId: app.id,
            ),
          ),
        ).then((_) => _refresh());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [const Color(0xFF4F46E5).withOpacity(0.15), const Color(0xFF7C3AED).withOpacity(0.15)]),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.person_rounded, color: Color(0xFF4F46E5)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.applicantName.isNotEmpty ? app.applicantName : 'Pelamar',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        app.jobTitle,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(app.status),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              app.coverLetter,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final colors = {
      'pending': Colors.orange,
      'accepted': Colors.green,
      'rejected': Colors.redAccent,
    };
    final labels = {
      'pending': 'Menunggu',
      'accepted': 'Diterima',
      'rejected': 'Ditolak',
    };
    final color = colors[status] ?? Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        labels[status] ?? status,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color),
      ),
    );
  }
}
