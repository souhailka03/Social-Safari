import 'package:flutter/material.dart';

class PersonalInfoForm extends StatelessWidget {
  const PersonalInfoForm({Key? key}) : super(key: key);

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
            'Informations Personnelles',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildTextField(
            label: 'Nom complet',
            value: 'Nawal SAIDI',
          ),
          SizedBox(height: 16),
          _buildTextField(
            label: 'Email',
            value: 'nawal.saidi@gmail.com',
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),
          _buildTextField(
            label: 'Téléphone',
            value: '+212 6 12 34 56 78',
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16),
          _buildTextField(
            label: 'Bio',
            value:
                'Passionnée de design et de technologie. Je travaille comme UX designer à Paris.',
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFE5E7EB),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFE5E7EB),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
