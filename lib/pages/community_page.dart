import 'package:flutter/material.dart';
import '../widgets/community widgets/navigation_tabs.dart';
import '../widgets/community widgets/post_card.dart';
import '../widgets/community widgets/noouveaupublicationmodel.dart';
import '../widgets/accueil widgets/advanced_search_bar.dart';
import '../widgets/community widgets/discussion_widget.dart';
import '../widgets/community widgets/reply_modal.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _currentTab = 0;

  void _showNewPublicationModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: const NewPublicationModal(),
      ),
    );
  }

  Widget _buildCurrentView() {
    if (_currentTab == 1) {
      return DiscussionPage();
    }
    // Vue des expériences (vue par défaut)
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          children: const [
            PostCard(
              name: 'Said Elhwate',
              timestamp: 'Il y a 2 heures',
              content: 'cette montagne offre un défi physique considérable, mais les vues panoramiques en valent vraiment la peine.',
              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRa4Mm_64eOes8mCZIACdTzqXeE833sueN_A&s',
              likes: 24,
              comments: 8,
              verified: true,
            ),
            PostCard(
              name: 'Hind Saaoudi',
              timestamp: 'Il y a 5 heures',
              content: 'J\'ai été agréablement surpris par la qualité de l\'enneigement et par les paysages époustouflants. Les pistes étaient bien entretenues, et l\'atmosphère était conviviale.',
              imageUrl: 'https://th.bing.com/th/id/R.95918a89cea9fcfaa5a9ffb882bc3462?rik=68kIP7Bmo%2fQAuQ&riu=http%3a%2f%2fabcyss-formation.com%2fimages%2fmontagne%2fformation-deplacement-montagne-hivernal.jpg&ehk=BS%2fyQQS%2bSjh0Xnysnz7AqBpisQRmjZu8SfTYZI%2fIClE%3d&risl=&pid=ImgRaw&r=0',
              likes: 42,
              comments: 15,
              verified: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                AdvancedSearchBar(
                  onSearch: (String value) {},
                  recentSearches: const [],
                  trendingSearches: const [],
                  recommendedSearches: const [],
                ),
                NavigationTabs(
                  onTabChanged: (index) {
                    setState(() {
                      _currentTab = index;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildCurrentView(),
                ),
              ],
            ),
            if (_currentTab == 0)
              Positioned(
                right: 21,
                bottom: 60,
                child: FloatingActionButton(
                  onPressed: () => _showNewPublicationModal(context),
                  backgroundColor: const Color(0xFF6D56FF),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}