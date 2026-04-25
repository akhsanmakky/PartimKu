import '../models/job.dart';
import '../models/application.dart';
import '../models/chat_message.dart';
import '../models/notification.dart';
import '../models/company_review.dart';
import '../models/job_history.dart';
import '../models/user.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final User _jobseekerUser = User(
    id: 'user_001',
    name: 'aksa',
    email: 'aksa@email.com',
    role: 'jobseeker',
    phone: '0812-3456-7890',
    location: 'Malang',
    bio: 'Mahasiswa semester 6 yang mencari pengalaman kerja part time di bidang admin dan customer service.',
    preferredJobType: 'part-time',
    preferredSchedule: 'weekend',
    skills: 'Microsoft Excel, admin, customer service, komunikasi',
  );

  final User _companyUser = User(
    id: 'comp_001',
    name: 'Admin Cafe Kita',
    email: 'admin@cafekita.com',
    role: 'company',
    phone: '0813-9876-5432',
    location: 'Jakarta Selatan',
    companyName: 'Cafe Kita',
    companyDescription: 'Cafe nyaman di Jakarta Selatan yang menyediakan berbagai minuman kopi dan makanan ringan.',
  );

  User _currentUser = User(
    id: 'user_001',
    name: 'aksa',
    email: 'aksa@email.com',
    role: 'jobseeker',
    phone: '0812-3456-7890',
    location: 'Jakarta Selatan',
    bio: 'Mahasiswa semester 6 yang mencari pengalaman kerja part time di bidang admin dan customer service.',
  );

  String get currentUserId => _currentUser.id;
  String get currentUserName => _currentUser.name;
  String get currentUserRole => _currentUser.role;

  User getCurrentUser() => _currentUser;

  void setCurrentUserFromLogin({
    required String email,
    String? name,
    String role = 'jobseeker',
    String? companyName,
  }) {
    if (role == 'company') {
      _currentUser = _companyUser.copyWith(
        email: email,
        name: name ?? email.split('@').first,
        companyName: companyName ?? 'Perusahaan Saya',
      );
    } else {
      _currentUser = _jobseekerUser.copyWith(
        email: email,
        name: name ?? email.split('@').first,
      );
    }
  }

  void updateCurrentUser({
    String? name,
    String? email,
    String? phone,
    String? location,
    String? bio,
    String? companyName,
    String? companyDescription,
  }) {
    _currentUser = _currentUser.copyWith(
      name: name,
      email: email,
      phone: phone,
      location: location,
      bio: bio,
      companyName: companyName,
      companyDescription: companyDescription,
    );
  }

    final List<Job> _jobs = [
    Job(
      id: 'job_001',
      title: 'Admin Part Time',
      company: 'Cafe Kita',
      companyId: 'comp_001',
      location: 'Jakarta Selatan',
      jobType: 'part-time',
      schedule: 'weekend',
      salary: 'Rp 2.500.000/bulan',
      description:
          'Bertanggung jawab atas pencatatan transaksi harian, mengelola stok barang, dan membantu operasional cafe di akhir pekan.',
      requirements: [
        'Mahir menggunakan Microsoft Excel',
        'Teliti dan terorganisir',
        'Berpengalaman minimal 1 tahun',
        'Bisa bekerja di hari Sabtu & Minggu'
      ],
      postedAt: DateTime.now().subtract(const Duration(days: 2)),
      isVerified: true,
    ),
    Job(
      id: 'job_002',
      title: 'Freelance Graphic Designer',
      company: 'Startup X',
      companyId: 'comp_002',
      location: 'Remote',
      jobType: 'freelance',
      schedule: 'flexible',
      salary: 'Rp 150.000/project',
      description:
          'Mendesain konten media sosial, poster promosi, dan materi branding untuk berbagai klien Startup X.',
      requirements: [
        'Mahir Adobe Illustrator & Photoshop',
        'Memiliki portofolio desain',
        'Bisa bekerja secara remote',
        'Kreatif dan inovatif'
      ],
      postedAt: DateTime.now().subtract(const Duration(days: 5)),
      isVerified: true,
    ),
    Job(
      id: 'job_003',
      title: 'Kasir Malam',
      company: 'Warung Makmur',
      companyId: 'comp_003',
      location: 'Bandung',
      jobType: 'part-time',
      schedule: 'weekday',
      salary: 'Rp 1.800.000/bulan',
      description:
          'Melayani pelanggan, mengelola kas, dan memastikan kebersihan area kasir pada shift malam.',
      requirements: [
        'Ramah dan komunikatif',
        'Bisa bekerja shift malam (17.00-23.00)',
        'Berpenampilan rapi',
        'Minimal lulus SMA'
      ],
      postedAt: DateTime.now().subtract(const Duration(days: 1)),
      isVerified: false,
    ),
    Job(
      id: 'job_004',
      title: 'Content Writer',
      company: 'Digital Agency Y',
      companyId: 'comp_004',
      location: 'Jakarta Pusat',
      jobType: 'full-time',
      schedule: 'weekday',
      salary: 'Rp 4.000.000/bulan',
      description:
          'Menulis artikel blog, copywriting untuk website, dan konten email marketing untuk berbagai klien.',
      requirements: [
        'Mahir bahasa Indonesia & Inggris',
        'Memahami SEO dasar',
        'Bisa bekerja deadline',
        'Pengalaman minimal 6 bulan'
      ],
      postedAt: DateTime.now().subtract(const Duration(days: 3)),
      isVerified: true,
    ),
    Job(
      id: 'job_005',
      title: 'Barista Part Time',
      company: 'Cafe Kita',
      companyId: 'comp_001',
      location: 'Jakarta Selatan',
      jobType: 'part-time',
      schedule: 'flexible',
      salary: 'Rp 2.000.000/bulan',
      description:
          'Menyajikan minuman kopi dan non-kopi, menjaga kebersihan peralatan, dan melayani pelanggan dengan ramah.',
      requirements: [
        'Suka dengan dunia kopi',
        'Bisa bekerja shift pagi/sore',
        'Cepat tanggap',
        'Training disediakan'
      ],
      postedAt: DateTime.now().subtract(const Duration(days: 4)),
      isVerified: true,
    ),
    Job(
      id: 'job_006',
      title: 'Driver Delivery',
      company: 'Logistik Cepat',
      companyId: 'comp_005',
      location: 'Surabaya',
      jobType: 'full-time',
      schedule: 'weekend',
      salary: 'Rp 3.500.000/bulan',
      description:
          'Mengantarkan paket ke alamat pelanggan dengan aman dan tepat waktu di area Surabaya.',
      requirements: [
        'Memiliki SIM C aktif',
        'Memiliki kendaraan sendiri',
        'Mengetahui jalan di Surabaya',
        'Bertanggung jawab'
      ],
      postedAt: DateTime.now().subtract(const Duration(days: 6)),
      isVerified: false,
    ),
  ];

  final List<Application> _applications = [
    Application(
      id: 'app_001',
      jobId: 'job_001',
      jobTitle: 'Admin Part Time',
      companyName: 'Cafe Kita',
      userId: 'user_002',
      applicantName: 'Ahmad Fauzi',
      status: 'pending',
      coverLetter: 'Saya memiliki pengalaman 2 tahun sebagai admin di cafe sebelumnya. Saya mahir Excel dan sangat teliti.',
      appliedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Application(
      id: 'app_002',
      jobId: 'job_005',
      jobTitle: 'Barista Part Time',
      companyName: 'Cafe Kita',
      userId: 'user_003',
      applicantName: 'Siti Nurhaliza',
      status: 'pending',
      coverLetter: 'Saya sangat menyukai dunia kopi dan ingin belajar lebih banyak. Saya bisa bekerja shift pagi maupun sore.',
      appliedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Application(
      id: 'app_003',
      jobId: 'job_001',
      jobTitle: 'Admin Part Time',
      companyName: 'Cafe Kita',
      userId: 'user_004',
      applicantName: 'Budi Santoso',
      status: 'accepted',
      coverLetter: 'Saya memiliki pengalaman sebagai admin selama 1 tahun dan siap bekerja di akhir pekan.',
      appliedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  final List<ChatMessage> _chatMessages = [
    ChatMessage(
      id: 'chat_001',
      senderId: 'comp_001',
      senderName: 'Cafe Kita',
      receiverId: 'user_001',
      message: 'Halo! Terima kasih telah melamar di Cafe Kita. Kapan Anda bisa datang untuk interview?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ChatMessage(
      id: 'chat_002',
      senderId: 'user_001',
      senderName: 'aksa',
      receiverId: 'comp_001',
      message: 'Halo! Saya bisa datang hari Sabtu jam 10 pagi. Apakah bisa?',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

    final List<AppNotification> _notifications = [
    AppNotification(
      id: 'notif_001',
      title: 'Lowongan Baru!',
      message: 'Cafe Kita membuka posisi Barista Part Time di Jakarta Selatan. Jangan lewatkan!',
      jobId: 'job_005',
      companyId: 'comp_001',
      isRead: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      type: 'new_job',
    ),
    AppNotification(
      id: 'notif_002',
      title: 'Status Lamaran Diperbarui',
      message: 'Lamaran Anda untuk Admin Part Time di Cafe Kita sedang direview.',
      jobId: 'job_001',
      companyId: 'comp_001',
      isRead: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      type: 'status_update',
    ),
    AppNotification(
      id: 'notif_003',
      title: 'Lowongan Baru!',
      message: 'Digital Agency Y mencari Content Writer full-time di Jakarta Pusat.',
      jobId: 'job_004',
      companyId: 'comp_004',
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      type: 'new_job',
    ),
    AppNotification(
      id: 'notif_004',
      title: 'Pesan Baru',
      message: 'Anda menerima pesan baru dari Startup X.',
      companyId: 'comp_002',
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      type: 'message',
    ),
    AppNotification(
      id: 'notif_005',
      title: 'Tips Karier',
      message: 'Lengkapi profil Anda untuk meningkatkan peluang diterima!',
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      type: 'general',
    ),
  ];

    final List<CompanyReview> _companyReviews = [
    CompanyReview(
      id: 'rev_001',
      companyId: 'comp_001',
      companyName: 'Cafe Kita',
      reviewerName: 'Ahmad Fauzi',
      rating: 4.5,
      review: 'Lingkungan kerja yang sangat nyaman dan tim yang supportive. Gaji tepat waktu setiap bulan.',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    CompanyReview(
      id: 'rev_002',
      companyId: 'comp_001',
      companyName: 'Cafe Kita',
      reviewerName: 'Siti Nurhaliza',
      rating: 5.0,
      review: 'Saya belajar banyak tentang dunia kopi di sini. Manajemen sangat profesional.',
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
    ),
    CompanyReview(
      id: 'rev_003',
      companyId: 'comp_001',
      companyName: 'Cafe Kita',
      reviewerName: 'Budi Santoso',
      rating: 4.0,
      review: 'Jam kerja fleksibel, cocok untuk mahasiswa. Tempatnya bersih dan rapi.',
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
    ),
    CompanyReview(
      id: 'rev_004',
      companyId: 'comp_002',
      companyName: 'Startup X',
      reviewerName: 'Dewi Lestari',
      rating: 4.8,
      review: 'Project menarik dan kreativitas sangat dihargai. Bayaran sesuai dengan kesepakatan.',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    CompanyReview(
      id: 'rev_005',
      companyId: 'comp_002',
      companyName: 'Startup X',
      reviewerName: 'Rudi Hartono',
      rating: 4.2,
      review: 'Bisa remote kerja, briefing jelas. Kadang deadline mepet tapi masih wajar.',
      createdAt: DateTime.now().subtract(const Duration(days: 50)),
    ),
    CompanyReview(
      id: 'rev_006',
      companyId: 'comp_003',
      companyName: 'Warung Makmur',
      reviewerName: 'Andi Wijaya',
      rating: 3.5,
      review: 'Pekerjaan cukup rutin. Bosnya baik tapi shift malam cukup melelahkan.',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    CompanyReview(
      id: 'rev_007',
      companyId: 'comp_004',
      companyName: 'Digital Agency Y',
      reviewerName: 'Lisa Permata',
      rating: 4.6,
      review: 'Agency yang sangat terorganisir. Banyak belajar dari senior writer di sini.',
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    CompanyReview(
      id: 'rev_008',
      companyId: 'comp_005',
      companyName: 'Logistik Cepat',
      reviewerName: 'Eko Prasetyo',
      rating: 4.0,
      review: 'Bayaran mingguan, jelas dan transparan. Rute antar cukup padat di hari Sabtu.',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

    final List<JobHistory> _jobHistories = [
    JobHistory(
      id: 'hist_001',
      jobTitle: 'Waiter Part Time',
      companyName: 'Restoran Sederhana',
      companyId: 'comp_010',
      location: 'Jakarta Barat',
      salary: 'Rp 2.200.000/bulan',
      startDate: DateTime(2023, 6, 1),
      endDate: DateTime(2023, 9, 30),
      status: 'completed',
      notes: 'Melayani pelanggan dan membantu operasional restoran.',
    ),
    JobHistory(
      id: 'hist_002',
      jobTitle: 'Data Entry Freelance',
      companyName: 'PT Teknologi Nusantara',
      companyId: 'comp_011',
      location: 'Remote',
      salary: 'Rp 100.000/project',
      startDate: DateTime(2023, 10, 1),
      endDate: DateTime(2024, 1, 15),
      status: 'completed',
      notes: 'Memasukkan data penjualan harian ke dalam spreadsheet.',
    ),
    JobHistory(
      id: 'hist_003',
      jobTitle: 'Kasir',
      companyName: 'Minimarket Sejahtera',
      companyId: 'comp_012',
      location: 'Depok',
      salary: 'Rp 2.500.000/bulan',
      startDate: DateTime(2024, 2, 1),
      endDate: DateTime(2024, 5, 31),
      status: 'completed',
      notes: 'Mengelola transaksi kas harian dan stock opname.',
    ),
    JobHistory(
      id: 'hist_004',
      jobTitle: 'Social Media Admin',
      companyName: 'Brand Lokal ID',
      companyId: 'comp_013',
      location: 'Jakarta Selatan',
      salary: 'Rp 3.000.000/bulan',
      startDate: DateTime(2024, 6, 1),
      endDate: DateTime(2024, 8, 31),
      status: 'completed',
      notes: 'Mengelola Instagram dan TikTok brand, membuat konten harian.',
    ),
    JobHistory(
      id: 'hist_005',
      jobTitle: 'Customer Service Online',
      companyName: 'E-Shop Indonesia',
      companyId: 'comp_014',
      location: 'Remote',
      salary: 'Rp 2.800.000/bulan',
      startDate: DateTime(2024, 9, 1),
      status: 'on-going',
      notes: 'Menjawab pertanyaan pelanggan via chat dan email.',
    ),
  ];

    List<Job> getJobs() => List.unmodifiable(_jobs);

  Job? getJobById(String id) {
    try {
      return _jobs.firstWhere((j) => j.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Job> filterJobs({
    String? schedule,
    String? location,
    String? jobType,
    String? query,
  }) {
    return _jobs.where((job) {
      final matchSchedule = schedule == null ||
          schedule.isEmpty ||
          job.schedule.toLowerCase() == schedule.toLowerCase();
      final matchLocation = location == null ||
          location.isEmpty ||
          job.location.toLowerCase().contains(location.toLowerCase());
      final matchJobType = jobType == null ||
          jobType.isEmpty ||
          job.jobType.toLowerCase() == jobType.toLowerCase();
      final matchQuery = query == null ||
          query.isEmpty ||
          job.title.toLowerCase().contains(query.toLowerCase()) ||
          job.company.toLowerCase().contains(query.toLowerCase()) ||
          job.location.toLowerCase().contains(query.toLowerCase());
      return matchSchedule && matchLocation && matchJobType && matchQuery;
    }).toList();
  }

  List<String> getLocations() {
    final locations = _jobs.map((j) => j.location).toSet().toList();
    locations.sort();
    return locations;
  }

    List<Job> getCompanyJobs(String companyId) {
    return _jobs.where((j) => j.companyId == companyId).toList()
      ..sort((a, b) => b.postedAt.compareTo(a.postedAt));
  }

  void postJob(Job job) {
    _jobs.add(job);
  }

  void deleteJob(String jobId) {
    _jobs.removeWhere((j) => j.id == jobId);
  }

    List<Application> getApplications() {
    return List.unmodifiable(
      _applications.where((a) => a.userId == currentUserId).toList()
        ..sort((a, b) => b.appliedAt.compareTo(a.appliedAt)),
    );
  }

  List<Application> getJobApplications(String jobId) {
    return _applications.where((a) => a.jobId == jobId).toList()
      ..sort((a, b) => b.appliedAt.compareTo(a.appliedAt));
  }

  List<Application> getApplicantsForCompany(String companyId) {
    final companyName = _currentUser.companyName.isNotEmpty
        ? _currentUser.companyName
        : _currentUser.name;
    return _applications.where((a) => a.companyName == companyName).toList()
      ..sort((a, b) => b.appliedAt.compareTo(a.appliedAt));
  }

  bool applyForJob({
    required String jobId,
    required String jobTitle,
    required String companyName,
    required String coverLetter,
  }) {
    final alreadyApplied = _applications.any(
      (a) => a.jobId == jobId && a.userId == currentUserId,
    );
    if (alreadyApplied) return false;

    _applications.add(
      Application(
        id: 'app_${DateTime.now().millisecondsSinceEpoch}',
        jobId: jobId,
        jobTitle: jobTitle,
        companyName: companyName,
        userId: currentUserId,
        applicantName: currentUserName,
        status: 'pending',
        coverLetter: coverLetter,
        appliedAt: DateTime.now(),
      ),
    );
    return true;
  }

  bool updateApplicationStatus(String applicationId, String status) {
    final index = _applications.indexWhere((a) => a.id == applicationId);
    if (index != -1) {
      _applications[index] = _applications[index].copyWith(status: status);
      return true;
    }
    return false;
  }

    List<ChatMessage> getChatMessages(String otherPartyId) {
    return _chatMessages
        .where(
          (c) =>
              (c.senderId == currentUserId && c.receiverId == otherPartyId) ||
              (c.senderId == otherPartyId && c.receiverId == currentUserId),
        )
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  List<ChatMessage> getAllChatMessages() {
    return List.unmodifiable(_chatMessages.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp)));
  }

  void sendChatMessage({
    required String receiverId,
    required String receiverName,
    required String message,
  }) {
    _chatMessages.add(
      ChatMessage(
        id: 'chat_${DateTime.now().millisecondsSinceEpoch}',
        senderId: currentUserId,
        senderName: currentUserName,
        receiverId: receiverId,
        message: message,
        timestamp: DateTime.now(),
      ),
    );
  }

    List<AppNotification> getNotifications() {
    return List.unmodifiable(
      _notifications.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }

  int getUnreadNotificationCount() {
    return _notifications.where((n) => !n.isRead).length;
  }

  void markNotificationAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  void markAllNotificationsAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      if (!_notifications[i].isRead) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
    }
  }

    List<CompanyReview> getCompanyReviews(String companyId) {
    return List.unmodifiable(
      _companyReviews
          .where((r) => r.companyId == companyId)
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }

  double getCompanyAverageRating(String companyId) {
    final reviews = _companyReviews.where((r) => r.companyId == companyId).toList();
    if (reviews.isEmpty) return 0.0;
    final sum = reviews.fold<double>(0, (acc, r) => acc + r.rating);
    return double.parse((sum / reviews.length).toStringAsFixed(1));
  }

  int getCompanyReviewCount(String companyId) {
    return _companyReviews.where((r) => r.companyId == companyId).length;
  }

    List<JobHistory> getJobHistory() {
    return List.unmodifiable(
      _jobHistories.toList()..sort((a, b) => b.startDate.compareTo(a.startDate)),
    );
  }

  List<JobHistory> getCompletedJobs() {
    return List.unmodifiable(
      _jobHistories.where((h) => h.status == 'completed').toList()
        ..sort((a, b) => b.startDate.compareTo(a.startDate)),
    );
  }

  List<JobHistory> getOnGoingJobs() {
    return List.unmodifiable(
      _jobHistories.where((h) => h.status == 'on-going').toList()
        ..sort((a, b) => b.startDate.compareTo(a.startDate)),
    );
  }

    List<Job> getRecommendedJobs() {
    final user = getCurrentUser();
    final userSkills = user.skills
        .toLowerCase()
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final preferredType = user.preferredJobType.toLowerCase();
    final preferredSchedule = user.preferredSchedule.toLowerCase();

    final scoredJobs = _jobs.where((job) {
      return !_applications.any(
        (a) => a.jobId == job.id && a.userId == currentUserId,
      );
    }).map((job) {
      double score = 0;

      final jobText =
          '${job.title} ${job.description} ${job.requirements.join(' ')}'
              .toLowerCase();
      for (final skill in userSkills) {
        if (jobText.contains(skill)) score += 3;
      }

      if (preferredType.isNotEmpty && job.jobType.toLowerCase() == preferredType) {
        score += 5;
      }

      if (preferredSchedule.isNotEmpty &&
          job.schedule.toLowerCase() == preferredSchedule) {
        score += 4;
      }

      if (job.isVerified) score += 2;

      if (DateTime.now().difference(job.postedAt).inDays <= 3) score += 1;

      return MapEntry(job, score);
    }).toList();

    scoredJobs.sort((a, b) => b.value.compareTo(a.value));
    return scoredJobs.map((e) => e.key).take(6).toList();
  }

    void updateUserPreferences({
    String? preferredJobType,
    String? preferredSchedule,
    String? skills,
  }) {
    _currentUser = _currentUser.copyWith(
      preferredJobType: preferredJobType,
      preferredSchedule: preferredSchedule,
      skills: skills,
    );
  }

    void verifyJob(String jobId) {
    final index = _jobs.indexWhere((j) => j.id == jobId);
    if (index != -1) {
      _jobs[index] = _jobs[index].copyWith(isVerified: true);
    }
  }
}

