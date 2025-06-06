import 'package:flutter/material.dart';

class NewPublicationModal extends StatefulWidget {
  const NewPublicationModal({Key? key}) : super(key: key);

  @override
  State<NewPublicationModal> createState() => _NewPublicationModalState();
}

class _NewPublicationModalState extends State<NewPublicationModal> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: const BoxConstraints(
            maxWidth: 375,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -4,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 10),
                blurRadius: 15,
                spreadRadius: -3,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFE5E7EB),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nouvelle Publication',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 28/18,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.close, size: 21),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),

                // Text area section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 128,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _textController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: 'Partagez votre expérience ou posez votre question  ...',
                            hintStyle: TextStyle(
                              color: Color(0xFF6B7280),
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.image, color: Color(0xFF6D56FF)),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.videocam, color: Color(0xFF6D56FF)),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.link, color: Color(0xFF6D56FF)),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bottom buttons
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFE5E7EB),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          minimumSize: const Size(79.86, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Annuler',
                          style: TextStyle(
                            color: Color(0xFF4B5563),
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          // Handle publish
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6D56FF),
                          minimumSize: const Size(75.36, 36),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Publier',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
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
}