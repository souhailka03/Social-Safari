import 'package:flutter/material.dart';
import '../../pages/offer_details_page.dart';

class SpecialOffers extends StatefulWidget {
  final bool showAllOffers;
  final VoidCallback onToggleShowAll;

  const SpecialOffers({
    super.key,
    required this.showAllOffers,
    required this.onToggleShowAll,
  });

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedOffers = widget.showAllOffers
        ? offers
        : offers.take(2).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Promotions exclusives',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF11181C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: List.generate(
              (displayedOffers.length / 2).ceil(),
                  (rowIndex) {
                final startIndex = rowIndex * 2;
                final endIndex = (startIndex + 2).clamp(0, displayedOffers.length);
                final rowOffers = displayedOffers.sublist(startIndex, endIndex);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildOfferCard(rowOffers[0], context),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: rowOffers.length > 1
                            ? _buildOfferCard(rowOffers[1], context)
                            : const SizedBox(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: widget.onToggleShowAll,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF6D56FF),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                widget.showAllOffers ? 'Voir moins' : 'Voir plus',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(Map<String, String> offer, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OfferDetailsPage(offer: offer),
          ),
        );
      },
      child: OfferCard(offer: offer),
    );
  }
}

class OfferCard extends StatelessWidget {
  final Map<String, String> offer;

  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  offer['image']!,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        offer['rating']!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer['title']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      offer['price']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6D56FF),
                      ),
                    ),
                    const Text(
                      ' par nuit',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BellIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFCED0F8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.moveTo(9.65, 6.27418);
    path.lineTo(9.65, 4.96966);
    path.cubicTo(9.65, 3.28857, 8.2397, 1.92578, 6.5, 1.92578);
    path.cubicTo(4.7603, 1.92578, 3.35, 3.28857, 3.35, 4.96966);
    path.lineTo(3.35, 6.27418);
    path.cubicTo(3.35, 7.70915, 2, 8.05702, 2, 8.88321);
    path.cubicTo(2, 9.62244, 3.755, 10.1877, 6.5, 10.1877);
    path.cubicTo(9.245, 10.1877, 11, 9.62244, 11, 8.88321);
    path.cubicTo(11, 8.05702, 9.65, 7.70915, 9.65, 6.27418);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

final List<Map<String, String>> offers = [
  {
    'image': 'https://cdn.builder.io/api/v1/image/assets/TEMP/31c4d503958af5970b906f1211d9417ad979af09',
    'title': 'L\'étoile des Cévennes, France',
    'originalPrice': '2500MAD',
    'price': '2000MAD',
    'duration': '6 jours',
    'rating': '4.8 (1,423 avis)',
    'location': 'Cévennes, France',
    'hours': '9:00 - 18:00 (Dernière admission: 17:00)',
  },
  {
    'image': 'https://cdn.builder.io/api/v1/image/assets/TEMP/232b88eba8a0efbd6f060b1ed4304a5e516ca0ae',
    'title': 'Évasion insolite à Marrakech à prix DINGUE, Maroc',
    'originalPrice': '2000MAD',
    'price': '1850MAD',
    'duration': '4 jours',
    'rating': '5.0 (2,105 avis)',
    'location': 'Marrakech, Maroc',
    'hours': '10:00 - 20:00 (Dernière admission: 19:00)',
  },
  {
    'image': 'https://th.bing.com/th/id/R.8a9b81f2855a03e1d7ba38158d4e8d28?rik=T2Qs%2bwXHE8hb4A&pid=ImgRaw&r=0',
    'title': 'Séjour luxueux aux Maldives',
    'originalPrice': '8000MAD',
    'price': '6500MAD',
    'duration': '7 jours',
    'rating': '4.9 (3,487 avis)',
    'location': 'Malé, Maldives',
    'hours': '24h/24, 7j/7',
  },
  {
    'image': 'https://www.voyageavecnous.fr/wp-content/uploads/2022/10/apercu-activites-dubai.jpg',
    'title': 'Vacances de rêve à Dubaï',
    'originalPrice': '7000MAD',
    'price': '5500MAD',
    'duration': '5 jours',
    'rating': '4.8 (2,936 avis)',
    'location': 'Dubaï, Emirats Arabes Unis',
    'hours': '9:00 - 22:00',
  },
  {
    'image': 'https://www.travelive.com/public/img/travel2greece/vacation/athens-santorini/luxury-suite-with-private-pool-in-santorini.jpg',
    'title': 'Romance à Santorini, Grèce',
    'originalPrice': '4500MAD',
    'price': '3800MAD',
    'duration': '6 jours',
    'rating': '4.7 (1,876 avis)',
    'location': 'Santorini, Grèce',
    'hours': '8:00 - 19:00',
  },
  {
    'image': 'https://eluxtravel.com/media/cache/1920x850/uploads/img/mediablock_images/62badf986ecad_08.jpg',
    'title': 'Aventure luxueuse au Costa Rica',
    'originalPrice': '5000MAD',
    'price': '4200MAD',
    'duration': '8 jours',
    'rating': '4.6 (1,543 avis)',
    'location': 'San José, Costa Rica',
    'hours': '7:00 - 18:00',
  },
];