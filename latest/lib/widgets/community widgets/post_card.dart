import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String name;
  final String timestamp;
  final String content;
  final String imageUrl;
  final int likes;
  final int comments;
  final bool verified;

  const PostCard({
    Key? key,
    required this.name,
    required this.timestamp,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.verified,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFF3F4F6),
                child: Icon(Icons.person_outline, color: Color(0xFF9CA3AF)),
              ),
              SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (verified)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Icon(
                                      Icons.verified,
                                      size: 16,
                                      color: Color(0xFF6D56FF),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              timestamp,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 16,
                                  color: Color(0xFF6B7280),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '$likes',
                                  style: TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  size: 16,
                                  color: Color(0xFF6B7280),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '$comments',
                                  style: TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    if (imageUrl.isNotEmpty) ...[
                      SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                    SizedBox(height: 16),
                    Row(
                      children: [
                        TextButton.icon(
                          icon: Icon(Icons.share, size: 16),
                          label: Text('Partager'),
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Color(0xFF6B7280),
                          ),
                        ),
                        SizedBox(width: 16),
                        TextButton.icon(
                          icon: Icon(Icons.flag, size: 16),
                          label: Text('Signaler'),
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 