import 'package:flutter/material.dart';
import '../common/image_with_placeholder.dart';

class RecommendationsSection extends StatefulWidget {
  const RecommendationsSection({Key? key}) : super(key: key);

  @override
  _RecommendationsSectionState createState() => _RecommendationsSectionState();
}

class _RecommendationsSectionState extends State<RecommendationsSection> {
  String selectedFilter = 'Tous';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ImageWithPlaceholder(
                imageUrl: 'https://www.olevoyages.ma/olevoyage/public/images/1653176728931793436355607_w-1200_h-630_q-70_m-crop.jpg',
                width: double.infinity,
                height: 200,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF6D56FF),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Destination Tendance',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Séjour aux Maldives - À partir de 15000 Mad/pers',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Tous', selectedFilter == 'Tous'),
                  SizedBox(width: 12),
                  _buildFilterChip('Plages', selectedFilter == 'Plages'),
                  SizedBox(width: 12),
                  _buildFilterChip('Montagnes', selectedFilter == 'Montagnes'),
                  SizedBox(width: 12),
                  _buildFilterChip('Villes', selectedFilter == 'Villes'),
                  SizedBox(width: 12),
                  _buildFilterChip('Culture', selectedFilter == 'Culture'),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.65,
              children: _getFilteredRecommendations(),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  List<Widget> _getFilteredRecommendations() {
    final recommendations = [
      {
        'image': 'https://static1.evcdn.net/cdn-cgi/image/width=3840,height=3072,quality=70,fit=crop/offer/raw/2025/01/29/bce94ce4-1477-49db-a850-b6b0cc73a076.jpg',
        'title': 'Bali, Indonésie - 12000 Mad',
        'subtitle': 'Séjour plage et culture',
        'type': 'Plages',
      },
      {
        'image': 'https://www.interhome.fr/upload/travelguide/7081/responsive-images/ski-en-suisse-meilleurs-domaines-zermatt___responsive-content_1000_667.jpg',
        'title': 'Alpes Suisses - 9800 Mad',
        'subtitle': 'Ski et sports d\'hiver',
        'type': 'Montagnes',
      },
      {
        'image': 'https://media-cdn.tripadvisor.com/media/attractions-splice-spp-720x480/0c/0a/31/a2.jpg',
        'title': 'Marrakech - 4500 Mad',
        'subtitle': 'Circuit culturel et gastronomique',
        'type': 'Culture',
      },
      {
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR24BRvzgNbj8D0lwnDtAslXDfwd9fxhXXcyQ&s',
        'title': 'Santorini, Grèce - 8900 Mad',
        'subtitle': 'Séjour romantique',
        'type': 'Villes',
      },
      {
        'image': 'https://www.destinationtunisie.info/wp-content/uploads/2023/02/hotels-djerba-plage-adresse-contact-reservation.jpg',
        'title': 'Djerba, Tunisie - 3800 Mad',
        'subtitle': 'Île paisible avec plages et artisanat local',
        'type': 'Plages',
      },
      {
        'image': 'https://images5.bovpg.net/fw/back/uk/media/1/2/6/5/4/265470.jpg',
        'title': 'Charm el-Cheikh, Égypte - 5100 Mad',
        'subtitle': 'Plongée sous-marine et resorts de luxe',
        'type': 'Plages',
      },
    ];

    return recommendations.where((rec) {
      if (selectedFilter == 'Tous') return true;
      return rec['type'] == selectedFilter;
    }).map((rec) {
      return _buildRecommendationCard(
        image: rec['image'] ?? '',
        title: rec['title'] ?? 'Titre indisponible',
        subtitle: rec['subtitle'] ?? 'Sous-titre indisponible',
        relevance: '98% pertinent',
      );
    }).toList();
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Color(0xFF6D56FF) : Color(0xFFE5E7EB),
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Color(0xFF6D56FF) : Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard({
    required String image,
    required String title,
    required String subtitle,
    required String relevance,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8),
            ),
            child: ImageWithPlaceholder(
              imageUrl: image,
              height: 100,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      relevance,
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF6D56FF),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF6B7280),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
