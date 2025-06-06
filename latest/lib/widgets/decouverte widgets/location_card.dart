import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class LocationCard extends StatelessWidget {
  final String imageUrl;
  final String location;
  final double rating;
  final String description;
  final String price;
  final String author;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const LocationCard({
    Key? key,
    required this.imageUrl,
    required this.location,
    required this.rating,
    required this.description,
    required this.price,
    required this.author,
    this.isFavorite = false,
    this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: onFavoriteTap,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 17,
                      color: isFavorite ? AppColors.heartRed : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        location,
                        style: AppTextStyles.locationTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: AppColors.starYellow),
                        const SizedBox(width: 4),
                        Text(rating.toString(), style: AppTextStyles.locationTitle),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTextStyles.locationDescription,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(price, style: AppTextStyles.priceText),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, size: 12),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      author,
                      style: AppTextStyles.locationDescription,
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
