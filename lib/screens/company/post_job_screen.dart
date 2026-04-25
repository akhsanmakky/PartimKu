import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/job.dart';
import '../../services/api_service.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  _PostJobScreenState createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requirementsController = TextEditingController();

  String _jobType = 'part-time';
  String _schedule = 'weekday';

  bool _isLoading = false;

  final List<String> _jobTypes = ['full-time', 'part-time', 'freelance'];
  final List<String> _schedules = ['weekday', 'weekend', 'flexible'];

  void _postJob() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      final api = ApiService();
      final user = api.getCurrentUser();
      final companyName = user.companyName.isNotEmpty ? user.companyName : user.name;

      final newJob = Job(
        id: 'job_${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text.trim(),
        company: companyName,
        companyId: user.id,
        location: _locationController.text.trim(),
        jobType: _jobType,
        schedule: _schedule,
        salary: _salaryController.text.trim(),
        description: _descriptionController.text.trim(),
        requirements: _requirementsController.text
            .split('\n')
            .where((r) => r.trim().isNotEmpty)
            .toList(),
        postedAt: DateTime.now(),
      );

      api.postJob(newJob);

      setState(() => _isLoading = false);
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Lowongan berhasil diposting!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      );
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Posting Lowongan'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Judul Pekerjaan'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                validator: (v) => v == null || v.isEmpty ? 'Judul tidak boleh kosong' : null,
                decoration: const InputDecoration(hintText: 'Contoh: Admin Part Time'),
              ),
              const SizedBox(height: 20),

              _buildLabel('Lokasi'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                textInputAction: TextInputAction.next,
                validator: (v) => v == null || v.isEmpty ? 'Lokasi tidak boleh kosong' : null,
                decoration: const InputDecoration(hintText: 'Contoh: Jakarta Selatan'),
              ),
              const SizedBox(height: 20),

              _buildLabel('Gaji'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _salaryController,
                textInputAction: TextInputAction.next,
                validator: (v) => v == null || v.isEmpty ? 'Gaji tidak boleh kosong' : null,
                decoration: const InputDecoration(hintText: 'Contoh: Rp 2.500.000/bulan'),
              ),
              const SizedBox(height: 20),

              _buildLabel('Jenis Pekerjaan'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _jobTypes.map((type) {
                  final isSelected = _jobType == type;
                  return ChoiceChip(
                    label: Text(type[0].toUpperCase() + type.substring(1)),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _jobType = type),
                    selectedColor: const Color(0xFF4F46E5),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              _buildLabel('Jadwal'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _schedules.map((s) {
                  final isSelected = _schedule == s;
                  return ChoiceChip(
                    label: Text(s[0].toUpperCase() + s.substring(1)),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _schedule = s),
                    selectedColor: const Color(0xFF4F46E5),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              _buildLabel('Deskripsi Pekerjaan'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                validator: (v) => v == null || v.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
                decoration: const InputDecoration(
                  hintText: 'Jelaskan tugas dan tanggung jawab...',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 20),

              _buildLabel('Persyaratan (satu per baris)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _requirementsController,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                validator: (v) => v == null || v.isEmpty ? 'Persyaratan tidak boleh kosong' : null,
                decoration: const InputDecoration(
                  hintText: 'Mahir Excel\nTeliti\nBisa bekerja shift malam',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _postJob,
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2.5, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                        )
                      : const Text('Posting Lowongan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
