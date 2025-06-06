import 'package:flutter/material.dart';
import '../widgets/profile widgets/profile_header.dart';
import '../widgets/profile widgets/personal_info_form.dart';
import '../widgets/profile widgets/settings_section.dart';
import '../widgets/profile widgets/account_options.dart';
import '../widgets/profile widgets/history_section.dart';
import '../widgets/profile widgets/recommendations_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Navigation Tabs
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: _buildTab('Mon Profil', 0)),
                            Expanded(child: _buildTab('Historique', 1)),
                            Expanded(child: _buildTab('Recommandation', 2)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Content based on selected tab
                      if (_selectedTab == 0) ...[
                        ProfileHeader(),
                        SizedBox(height: 20),
                        PersonalInfoForm(),
                        SizedBox(height: 16),
                        SettingsSection(),
                        SizedBox(height: 16),
                        AccountOptions(),
                      ] else if (_selectedTab == 1) ...[
                        HistorySection(),
                      ] else ...[
                        RecommendationsSection(),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Color(0xFF6D56FF) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Color(0xFF6D56FF) : Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
