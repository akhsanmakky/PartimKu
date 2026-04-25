import 'package:flutter/material.dart';
import '../../models/company_review.dart';
import '../../services/api_service.dart';

class CompanyReviewsScreen extends StatelessWidget {
  final String companyId;
  final String companyName;

  const CompanyReviewsScreen({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  Widget _buildStarRating(double rating, {double size = 20}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final filled = index < rating.floor();
        final halfFilled = !filled && (index < rating);
        return Icon(
          halfFilled ? Icons.star_half_rounded : (filled ? Icons.star_rounded : Icons.star_border_rounded),
          color: Colors.amber[600],
          size: size,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final reviews = apiService.getCompanyReviews(companyId);
    final avgRating = apiService.getCompanyAverageRating(companyId);
    final reviewCount = apiService.getCompanyReviewCount(companyId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Perusahaan'),
        elevation: 0,
      ),
      body: Column(
        children: [

          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.15),
              ),
            ),
            child: Column(
              children: [
                Text(
                  companyName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      avgRating.toString(),
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStarRating(avgRating),
                        const SizedBox(height: 4),
                        Text(
                          '$reviewCount review',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                ...[5, 4, 3, 2, 1].map((star) {
                  final count = reviews.where((r) => r.rating.round() == star).length;
                  final pct = reviews.isEmpty ? 0.0 : count / reviews.length;
                  return _buildRatingBar(star, pct);
                }),
              ],
            ),
          ),

          Expanded(
            child: reviews.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.rate_review_outlined,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada review',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return _buildReviewCard(reviews[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int star, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            '$star',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          const SizedBox(width: 4),
          Icon(Icons.star_rounded, size: 14, color: Colors.amber[600]),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage,
                minHeight: 6,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber[600]!),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${(percentage * 100).toInt()}%',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(CompanyReview review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[200],
                child: Text(
                  review.reviewerName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    _buildStarRating(review.rating, size: 14),
                  ],
                ),
              ),
              Text(
                _formatDate(review.createdAt),
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review.review,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }
}

