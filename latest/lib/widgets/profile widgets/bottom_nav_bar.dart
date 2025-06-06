import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        items: [
          _buildNavItem(Icons.home_outlined, 'Accueil'),
          _buildNavItem(Icons.search, 'Recherche'),
          _buildNavItem(Icons.favorite_border, 'Favoris'),
          _buildNavItem(Icons.notifications_outlined, 'Notifications'),
          _buildNavItem(Icons.person_outline, 'Profil'),
        ],
        currentIndex: 4,
        selectedItemColor: Color(0xFF6D56FF),
        unselectedItemColor: Color(0xFFA09CAB),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 24,
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
