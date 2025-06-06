import 'package:flutter/material.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({Key? key}) : super(key: key);

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  bool isPublicProfile = true;
  bool isOnlineStatus = true;
  bool isMessagesEnabled = true;
  bool isNewsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSettingsCard(
          title: 'Paramètres de confidentialité',
          children: [
            _buildToggleRow(
              title: 'Profil public',
              value: isPublicProfile,
              onChanged: (value) => setState(() => isPublicProfile = value),
            ),
            SizedBox(height: 16),
            _buildToggleRow(
              title: 'Statut en ligne',
              value: isOnlineStatus,
              onChanged: (value) => setState(() => isOnlineStatus = value),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildSettingsCard(
          title: 'Notifications',
          children: [
            _buildToggleRow(
              title: 'Messages',
              value: isMessagesEnabled,
              onChanged: (value) => setState(() => isMessagesEnabled = value),
            ),
            SizedBox(height: 16),
            _buildToggleRow(
              title: 'Actualités',
              value: isNewsEnabled,
              onChanged: (value) => setState(() => isNewsEnabled = value),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildToggleRow({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Color(0xFF6D56FF),
        ),
      ],
    );
  }
}
