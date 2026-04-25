class Job {
  final String id;
  final String title;
  final String company;
  final String companyId;
  final String location;
  final String jobType; // full-time, part-time, freelance
  final String schedule; // weekday, weekend, flexible
  final String salary;
  final String description;
  final List<String> requirements;
  final DateTime postedAt;
  final bool isVerified;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.companyId,
    required this.location,
    required this.jobType,
    required this.schedule,
    required this.salary,
    required this.description,
    required this.requirements,
    required this.postedAt,
    this.isVerified = false,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      company: json['company'],
      companyId: json['companyId'],
      location: json['location'],
      jobType: json['jobType'],
      schedule: json['schedule'],
      salary: json['salary'],
      description: json['description'],
      requirements: List<String>.from(json['requirements']),
      postedAt: DateTime.parse(json['postedAt']),
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'companyId': companyId,
      'location': location,
      'jobType': jobType,
      'schedule': schedule,
      'salary': salary,
      'description': description,
      'requirements': requirements,
      'postedAt': postedAt.toIso8601String(),
      'isVerified': isVerified,
    };
  }

  Job copyWith({
    String? id,
    String? title,
    String? company,
    String? companyId,
    String? location,
    String? jobType,
    String? schedule,
    String? salary,
    String? description,
    List<String>? requirements,
    DateTime? postedAt,
    bool? isVerified,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      companyId: companyId ?? this.companyId,
      location: location ?? this.location,
      jobType: jobType ?? this.jobType,
      schedule: schedule ?? this.schedule,
      salary: salary ?? this.salary,
      description: description ?? this.description,
      requirements: requirements ?? this.requirements,
      postedAt: postedAt ?? this.postedAt,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

