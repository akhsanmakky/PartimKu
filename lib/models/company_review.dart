class CompanyReview {
  final String id;
  final String companyId;
  final String companyName;
  final String reviewerName;
  final double rating; // 1.0 - 5.0
  final String review;
  final DateTime createdAt;

  CompanyReview({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.reviewerName,
    required this.rating,
    required this.review,
    required this.createdAt,
  });

  factory CompanyReview.fromJson(Map<String, dynamic> json) {
    return CompanyReview(
      id: json['id'],
      companyId: json['companyId'],
      companyName: json['companyName'],
      reviewerName: json['reviewerName'],
      rating: json['rating'].toDouble(),
      review: json['review'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'companyName': companyName,
      'reviewerName': reviewerName,
      'rating': rating,
      'review': review,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

