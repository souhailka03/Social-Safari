import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final Icon icon;
  final bool isSelected;
  final VoidCallback onTap; // Add the onTap parameter

  const CategoryItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap, // Pass the onTap parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call onTap when the item is tapped
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon.icon, // Use the same icon as provided
              size: 20,   // Set the icon size here
              color: isSelected ? AppColors.primary : AppColors.textTertiary,
            ),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textTertiary,
                fontWeight: FontWeight.bold,
                fontSize: 9, // Reduced font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}

