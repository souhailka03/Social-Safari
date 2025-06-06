import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show bottom sheet for creating post
        _showCreatePostSheet(context);
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Color(0xFF6D56FF),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  void _showCreatePostSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Créer un post',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Partagez votre expérience...',
                border: InputBorder.none,
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.photo_library),
              label: Text('Ajouter une photo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],     // Remplace 'primary'
                foregroundColor: Colors.black,         // Remplace 'onPrimary'
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Publier'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6D56FF),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
