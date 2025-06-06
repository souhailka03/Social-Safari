import 'package:flutter/material.dart';

class AccountOptions extends StatefulWidget {
  const AccountOptions({Key? key}) : super(key: key);

  @override
  State<AccountOptions> createState() => _AccountOptionsState();
}

class _AccountOptionsState extends State<AccountOptions> {
  String selectedLanguage = 'Français';
  String selectedTheme = 'Clair';

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choisir la langue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Français'),
              onTap: () {
                setState(() => selectedLanguage = 'Français');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('English'),
              onTap: () {
                setState(() => selectedLanguage = 'English');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choisir le thème'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Clair'),
              onTap: () {
                setState(() => selectedTheme = 'Clair');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Sombre'),
              onTap: () {
                setState(() => selectedTheme = 'Sombre');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Changer le mot de passe'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Ancien mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nouveau mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirmer le mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              // Here you would typically handle the password change
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Mot de passe modifié avec succès')),
              );
            },
            child: Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            'Options du compte',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          _buildOptionRow(
            title: 'Changer le mot de passe',
            onTap: _showChangePasswordDialog,
          ),
          _buildOptionRow(
            title: 'Langue',
            value: selectedLanguage,
            onTap: _showLanguageDialog,
          ),
          _buildOptionRow(
            title: 'Thème',
            value: selectedTheme,
            onTap: _showThemeDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionRow({
    required String title,
    String? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14),
            ),
            Row(
              children: [
                if (value != null)
                  Text(
                    value,
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                    ),
                  ),
                SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: Color(0xFF6B7280),
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
