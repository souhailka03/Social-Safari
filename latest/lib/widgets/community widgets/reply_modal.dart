import 'package:flutter/material.dart';

class ReplyModal extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSubmit;
  final Function(String) onTextChanged;
  final String replyText;

  const ReplyModal({
    required this.onClose,
    required this.onSubmit,
    required this.onTextChanged,
    required this.replyText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Répondre à la discussion',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: onClose,
                      color: Color(0xFF9CA3AF),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      iconSize: 20,
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xFFE5E7EB),
                  height: 32,
                ),

                // Text field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFFE5E7EB),
                    ),
                  ),
                  child: TextField(
                    maxLines: 4,
                    minLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Écrivez votre réponse ici...',
                      hintStyle: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                      contentPadding: EdgeInsets.all(12),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1F2937),
                    ),
                    onChanged: onTextChanged,
                    controller: TextEditingController(text: replyText),
                  ),
                ),
                SizedBox(height: 16),

                // Attachment options
                Row(
                  children: [
                    _buildAttachmentButton(
                      icon: Icons.image_outlined,
                      label: 'Image',
                      onTap: () {},
                    ),
                    SizedBox(width: 16),
                    _buildAttachmentButton(
                      icon: Icons.videocam_outlined,
                      label: 'Vidéo',
                      onTap: () {},
                    ),
                    SizedBox(width: 16),
                    _buildAttachmentButton(
                      icon: Icons.link,
                      label: 'Lien',
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Cancel button
                    TextButton(
                      onPressed: onClose,
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xFF6B7280),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Annuler',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    // Submit button
                    ElevatedButton(
                      onPressed: replyText.isNotEmpty ? onSubmit : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6D56FF),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Envoyer',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFE5E7EB),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Color(0xFF6D56FF),
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}