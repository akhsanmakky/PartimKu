import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/application.dart';
import '../../services/api_service.dart';
import '../user/chat_screen.dart';

class CompanyApplicantDetailScreen extends StatefulWidget {
  final String jobId;
  final String jobTitle;
  final String? initialApplicationId;

  const CompanyApplicantDetailScreen({
    super.key,
    required this.jobId,
    required this.jobTitle,
    this.initialApplicationId,
  });

  @override
  _CompanyApplicantDetailScreenState createState() => _CompanyApplicantDetailScreenState();
}

class _CompanyApplicantDetailScreenState extends State<CompanyApplicantDetailScreen> {
  final ApiService _apiService = ApiService();

  void _updateStatus(String applicationId, String status) {
    _apiService.updateApplicationStatus(applicationId, status);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(status == 'accepted' ? 'Pelamar diterima!' : 'Pelamar ditolak.'),
        backgroundColor: status == 'accepted' ? Colors.green : Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final applicants = _apiService.getJobApplications(widget.jobId);

    if (applicants.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(title: Text(widget.jobTitle), elevation: 0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 64, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text('Belum ada pelamar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600])),
            ],
          ),
        ),
      );
    }

    final displayApplicants = widget.initialApplicationId != null
        ? applicants.where((a) => a.id == widget.initialApplicationId).toList()
        : applicants;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(widget.jobTitle),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: displayApplicants.length,
        itemBuilder: (context, index) {
          final app = displayApplicants[index];
          return _buildDetailCard(app)
              .animate()
              .fadeIn(delay: (index * 100).ms, duration: 500.ms)
              .slideY(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOut);
        },
      ),
    );
  }

  Widget _buildDetailCard(Application app) {
    return Container(
      padding: const EdgeInsets.all(20),
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
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [const Color(0xFF4F46E5).withOpacity(0.15), const Color(0xFF7C3AED).withOpacity(0.15)]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.person_rounded, color: Color(0xFF4F46E5), size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.applicantName.isNotEmpty ? app.applicantName : 'Pelamar',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    _buildStatusChip(app.status),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey[100]),
          const SizedBox(height: 16),
          Text(
            'Surat Lamaran',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey[500]),
          ),
          const SizedBox(height: 8),
          Text(
            app.coverLetter,
            style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.6),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey[100]),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: app.status == 'accepted' ? null : () => _updateStatus(app.id, 'accepted'),
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text('Terima'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: app.status == 'rejected' ? null : () => _updateStatus(app.id, 'rejected'),
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Tolak'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      companyId: app.userId,
                      companyName: app.applicantName.isNotEmpty ? app.applicantName : 'Pelamar',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF4F46E5)),
              label: const Text('Chat dengan Pelamar', style: TextStyle(color: Color(0xFF4F46E5))),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: const Color(0xFF4F46E5).withOpacity(0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
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
