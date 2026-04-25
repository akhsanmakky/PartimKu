class Application {
  final String id;
  final String jobId;
  final String jobTitle;
  final String companyName;
  final String userId;
  final String applicantName;
  final String status; // pending, accepted, rejected
  final String coverLetter;
  final DateTime appliedAt;

  Application({
    required this.id,
    required this.jobId,
    required this.jobTitle,
    required this.companyName,
    required this.userId,
    this.applicantName = '',
    required this.status,
    required this.coverLetter,
    required this.appliedAt,
  });

  Application copyWith({
    String? id,
    String? jobId,
    String? jobTitle,
    String? companyName,
    String? userId,
    String? applicantName,
    String? status,
    String? coverLetter,
    DateTime? appliedAt,
  }) {
    return Application(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      userId: userId ?? this.userId,
      applicantName: applicantName ?? this.applicantName,
      status: status ?? this.status,
      coverLetter: coverLetter ?? this.coverLetter,
      appliedAt: appliedAt ?? this.appliedAt,
    );
  }

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      jobId: json['jobId'],
      jobTitle: json['jobTitle'],
      companyName: json['companyName'],
      userId: json['userId'],
      applicantName: json['applicantName'] ?? '',
      status: json['status'],
      coverLetter: json['coverLetter'],
      appliedAt: DateTime.parse(json['appliedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobId': jobId,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'userId': userId,
      'applicantName': applicantName,
      'status': status,
      'coverLetter': coverLetter,
      'appliedAt': appliedAt.toIso8601String(),
    };
  }
}

