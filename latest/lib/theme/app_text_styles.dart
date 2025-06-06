import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle statusBarTime = GoogleFonts.inter(
    fontSize: 9,
    fontWeight: FontWeight.w700,
    color: Color(0xFF11181C),
  );

  static final TextStyle title = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static final TextStyle searchHint = GoogleFonts.inter(
    fontSize: 14,
    color: Color(0xFF6B7280),
  );

  static final TextStyle filterChip = GoogleFonts.inter(
    fontSize: 14,
    color: Colors.black,
  );

  static final TextStyle categoryLabel = GoogleFonts.inter(
    fontSize: 12,
    color: AppColors.primary,
  );

  static final TextStyle locationTitle = GoogleFonts.inter(
    fontSize: 14,
    color: Colors.black,
  );

  static final TextStyle locationDescription = GoogleFonts.inter(
    fontSize: 12,
    color: Color(0xFF4B5563),
  );

  static final TextStyle priceText = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static final TextStyle bottomNavLabel = GoogleFonts.archivo(
    fontSize: 6,
    fontWeight: FontWeight.w700,
    color: AppColors.iconGray,
  );
}