import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String name;
  final String timestamp;
  final bool verified;

  const UserAvatar({
    Key? key,
    required this.name,
    required this.timestamp,
    this.verified = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar circle with user icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: ClipOval(
              child: Image.network(
                'https://media.istockphoto.com/id/839214266/photo/intense-portrait-of-a-man-with-beard.jpg?s=612x612&w=0&k=20&c=L3qwp0pKyKB7NeNtnvwfg2vzwZzLz8ByVHRqxOnAAJA=', // ← Remplace avec ton URL
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
          ),

        ),
        SizedBox(width: 12), // Gap between avatar and text
        // User info column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name and verification badge row
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                if (verified) ...[
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xFFE6F4EA),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          color: Color(0xFF1E8E3E),
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Vérifié',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF1E8E3E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
            SizedBox(height: 4),
            // Timestamp
            Text(
              timestamp,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
