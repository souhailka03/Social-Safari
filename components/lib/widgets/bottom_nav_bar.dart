import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.gray400.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: 'assets/icons/home.svg',
            label: 'Accueil',
            isSelected: false,
          ),
          _NavItem(
            icon: 'assets/icons/discover.svg',
            label: 'Decouverte',
            isSelected: false,
          ),
          _NavItem(
            icon: 'assets/icons/calendar.svg',
            label: 'Réservation',
            isSelected: false,
          ),
          _NavItem(
            icon: 'assets/icons/compare.svg',
            label: 'Comparateur',
            isSelected: true,
          ),
          _NavItem(
            icon: 'assets/icons/community.svg',
            label: 'Communaute',
            isSelected: false,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.gray400;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 6,
            fontWeight: FontWeight.w700,
            fontFamily: 'Archivo',
          ),
        ),
      ],
    );
  }
}