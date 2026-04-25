class AppNotification {
  final String id;
  final String title;
  final String message;
  final String? jobId;
  final String? companyId;
  final bool isRead;
  final DateTime createdAt;
  final String type; // new_job, status_update, message, general

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    this.jobId,
    this.companyId,
    required this.isRead,
    required this.createdAt,
    required this.type,
  });

  AppNotification copyWith({
    String? id,
    String? title,
    String? message,
    String? jobId,
    String? companyId,
    bool? isRead,
    DateTime? createdAt,
    String? type,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      jobId: jobId ?? this.jobId,
      companyId: companyId ?? this.companyId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
    );
  }

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      jobId: json['jobId'],
      companyId: json['companyId'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'jobId': jobId,
      'companyId': companyId,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'type': type,
    };
  }
}

