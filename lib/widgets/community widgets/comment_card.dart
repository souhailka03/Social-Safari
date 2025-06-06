import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String author;
  final String time;
  final String content;
  final int votes;
  final VoidCallback onUpvote;

  const CommentCard({
    required this.author,
    required this.time,
    required this.content,
    required this.votes,
    required this.onUpvote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
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
                        Text(
                          author,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_upward),
                              onPressed: onUpvote,
                              color: Color(0xFF9CA3AF),
                            ),
                            Text(
                              '$votes',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () {},
                          color: Color(0xFF9CA3AF),
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
                SizedBox(height: 16),
                Row(
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.reply, size: 16),
                      label: Text('Répondre'),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xFF6B7280),
                      ),
                    ),
                    SizedBox(width: 16),
                    TextButton.icon(
                      icon: Icon(Icons.share, size: 16),
                      label: Text('Partager'),
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
    );
  }
} 