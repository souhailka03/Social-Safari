import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String date;
  final int rating;
  final String comment;
  final bool isVerified;
  final String? userImage;

  const ReviewCard({
    Key? key,
    required this.userName,
    required this.date,
    required this.rating,
    required this.comment,
    this.isVerified = false,
    this.userImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      userImage != null ? NetworkImage(userImage!) : null,
                  child: userImage == null ? const Icon(Icons.person) : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (isVerified) ...[
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              comment,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
