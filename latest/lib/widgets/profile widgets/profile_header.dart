import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  String get _optimizedImageUrl {
    const url =
        'https://cdn.builder.io/api/v1/image/assets/TEMP/216133e8eea83f5382dba7c712a5a691d784f9b3';
    return '$url?auto=compress&w=150&q=80';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 73,
              height: 73,
              decoration: BoxDecoration(
                color: const Color(0xFFCED0F8),
                borderRadius: BorderRadius.circular(40),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                  imageUrl: _optimizedImageUrl,
                  width: 73,
                  height: 73,
                  fit: BoxFit.cover,
                  memCacheHeight: 146,
                  fadeInDuration: const Duration(milliseconds: 300),
                  fadeOutDuration: const Duration(milliseconds: 300),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    period: const Duration(milliseconds: 1000),
                    child: Container(
                      width: 73,
                      height: 73,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFF6D56FF),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF6D56FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.edit,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Nawal SAIDI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'En ligne',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
