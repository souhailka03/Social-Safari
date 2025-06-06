import 'package:flutter/material.dart';
import 'post_card.dart';
import 'comment_card.dart';
import 'reply_modal.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  Map<String, int> votes = {
    'mainPost': 24,
    'comment1': 24,
    'comment2': 18,
  };

  int activeUsers = 28;
  String sortBy = 'popular';
  bool showReplyModal = false;
  String replyText = '';

  void toggleVote(String postId, String direction) {
    setState(() {
      if (direction == 'up') {
        votes[postId] = votes[postId]! + 1;
      } else {
        votes[postId] = votes[postId]! - 1;
      }
    });
  }

  void toggleReplyModal(bool show) {
    setState(() {
      showReplyModal = show;
    });
  }

  void handleReply() {
    setState(() {
      showReplyModal = false;
      replyText = '';
    });
  }

  void handleSort(String value) {
    setState(() {
      sortBy = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              // Main post
              PostCard(
                name: "Pierre Dubois",
                timestamp: "Il y a 2 heures",
                content: "Quelles sont vos meilleures astuces pour améliorer la productivité au travail tout en maintenant un bon équilibre vie professionnelle/vie personnelle ?",
                imageUrl: "", // Champ vide car pas d'image
                likes: votes['mainPost'] ?? 24,
                comments: 15,
                verified: true,
              ),

              // Comments
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PostCard(
                  name: "Said Alaa",
                  timestamp: "Il y a 1 heure",
                  content: "Je recommande la technique Pomodoro : 25 minutes de travail concentré suivies de 5 minutes de pause. Cela m'aide énormément à rester productive tout au long de la journée.",
                  imageUrl: "",
                  likes: votes['comment1'] ?? 24,
                  comments: 5,
                  verified: false,
                ),
              ),

              PostCard(
                name: "Amine Fikri",
                timestamp: "Il y a 45 minutes",
                content: "La planification est essentielle. Je consacre 15 minutes chaque matin pour organiser ma journée et définir mes priorités. Cela me permet d'être plus efficace et de mieux gérer mon temps.",
                imageUrl: "",
                likes: votes['comment2'] ?? 18,
                comments: 3,
                verified: true,
              ),
            ],
          ),
        ),

        // Bottom bar
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFE5E7EB)),
              ),
            ),
            padding: EdgeInsets.all(17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => toggleReplyModal(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6D56FF),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Répondre à la discussion',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.people_outline, color: Color(0xFF6B7280)),
                    SizedBox(width: 8),
                    Text(
                      '$activeUsers actifs',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Reply modal
        if (showReplyModal)
          ReplyModal(
            onClose: () => toggleReplyModal(false),
            onSubmit: handleReply,
            onTextChanged: (value) {
              setState(() => replyText = value);
            },
            replyText: replyText,
          ),
      ],
    );
  }
} 