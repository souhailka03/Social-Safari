import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '9:41 AM',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/signal.svg', width: 11, height: 7),
                      const SizedBox(width: 82),
                      SvgPicture.asset('assets/icons/battery.svg', width: 26, height: 8),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Comparateur de Prix',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Container(
                        width: 14,
                        height: 14,
                        color: AppColors.gray600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 56),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.borderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        _TabItem(
                          text: 'Hébergement',
                          isSelected: true,
                        ),
                        const SizedBox(width: 8),
                        _TabItem(
                          text: 'Transport',
                          isSelected: false,
                        ),
                        const SizedBox(width: 8),
                        _TabItem(
                          text: 'Activités',
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _TabItem({
    required this.text,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.gray600,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}