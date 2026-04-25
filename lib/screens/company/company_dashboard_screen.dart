import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/job.dart';
import '../../services/api_service.dart';
import 'post_job_screen.dart';
import 'company_applicant_detail_screen.dart';

class CompanyDashboardScreen extends StatefulWidget {
  const CompanyDashboardScreen({super.key});

  @override
  _CompanyDashboardScreenState createState() => _CompanyDashboardScreenState();
}

class _CompanyDashboardScreenState extends State<CompanyDashboardScreen> {
  final ApiService _apiService = ApiService();

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = _apiService.getCurrentUser();
    final jobs = _apiService.getCompanyJobs(user.id);

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kelola Lowongan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${jobs.length} lowongan aktif',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: jobs.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.work_off_outlined, size: 64, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text('Belum ada lowongan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final job = jobs[index];
                        final applicants = _apiService.getJobApplications(job.id);
                        final pendingCount = applicants.where((a) => a.status == 'pending').length;
                        return _buildJobCard(job, applicants.length, pendingCount)
                            .animate()
                            .fadeIn(delay: (index * 100).ms, duration: 500.ms)
                            .slideY(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOut);
                      },
                      childCount: jobs.length,
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PostJobScreen()),
          ).then((result) {
            if (result == true) _refresh();
          });
        },
        backgroundColor: const Color(0xFF4F46E5),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Posting'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildJobCard(Job job, int totalApplicants, int pendingApplicants) {
    return Container(
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
              Expanded(
                child: Text(
                  job.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _jobTypeColor(job.jobType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  job.jobType[0].toUpperCase() + job.jobType.substring(1),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _jobTypeColor(job.jobType),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(job.location, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          const SizedBox(height: 14),
          Divider(color: Colors.grey[100]),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildStat(Icons.people_outline, '$totalApplicants Pelamar', Colors.blue),
              const SizedBox(width: 16),
              if (pendingApplicants > 0)
                _buildStat(Icons.hourglass_top_rounded, '$pendingApplicants Menunggu', Colors.orange),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CompanyApplicantDetailScreen(jobId: job.id, jobTitle: job.title),
                ),
              ).then((_) => _refresh());
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF4F46E5).withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Lihat Pelamar →',
                  style: TextStyle(
                    color: Color(0xFF4F46E5),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Color _jobTypeColor(String type) {
    switch (type) {
      case 'full-time':
        return Colors.blue;
      case 'part-time':
        return Colors.orange;
      case 'freelance':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
