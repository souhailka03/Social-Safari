import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/discovery_screen.dart';
import '../pages/profile_screen.dart';
import '../pages/comparator_screen.dart';
import '../pages/reservation_page.dart';
import '../pages/community_page.dart';
import '../widgets/bottom_navigation.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const DiscoveryScreen(),
    const ReservationPage(offerDetails: {},),
    const ComparatorScreen(),
    const CommunityScreen(),
    const ProfileScreen(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
} 