class JobHistory {
  final String id;
  final String jobTitle;
  final String companyName;
  final String companyId;
  final String location;
  final String salary;
  final DateTime startDate;
  final DateTime? endDate;
  final String status; // completed, on-going
  final String? notes;

  JobHistory({
    required this.id,
    required this.jobTitle,
    required this.companyName,
    required this.companyId,
    required this.location,
    required this.salary,
    required this.startDate,
    this.endDate,
    required this.status,
    this.notes,
  });

  factory JobHistory.fromJson(Map<String, dynamic> json) {
    return JobHistory(
      id: json['id'],
      jobTitle: json['jobTitle'],
      companyName: json['companyName'],
      companyId: json['companyId'],
      location: json['location'],
      salary: json['salary'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'companyId': companyId,
      'location': location,
      'salary': salary,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'status': status,
      'notes': notes,
    };
  }
}

