class User {
  final String id;
  String name;
  String email;
  final String role; // jobseeker, company
  String phone;
  String location;
  String bio;
  String companyName;
  String companyDescription;
  String preferredJobType; // full-time, part-time, freelance, or ''
  String preferredSchedule; // weekday, weekend, flexible, or ''
  String skills; // comma-separated skills

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone = '',
    this.location = '',
    this.bio = '',
    this.companyName = '',
    this.companyDescription = '',
    this.preferredJobType = '',
    this.preferredSchedule = '',
    this.skills = '',
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? phone,
    String? location,
    String? bio,
    String? companyName,
    String? companyDescription,
    String? preferredJobType,
    String? preferredSchedule,
    String? skills,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      companyName: companyName ?? this.companyName,
      companyDescription: companyDescription ?? this.companyDescription,
      preferredJobType: preferredJobType ?? this.preferredJobType,
      preferredSchedule: preferredSchedule ?? this.preferredSchedule,
      skills: skills ?? this.skills,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      bio: json['bio'] ?? '',
      companyName: json['companyName'] ?? '',
      companyDescription: json['companyDescription'] ?? '',
      preferredJobType: json['preferredJobType'] ?? '',
      preferredSchedule: json['preferredSchedule'] ?? '',
      skills: json['skills'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'location': location,
      'bio': bio,
      'companyName': companyName,
      'companyDescription': companyDescription,
      'preferredJobType': preferredJobType,
      'preferredSchedule': preferredSchedule,
      'skills': skills,
    };
  }
}

