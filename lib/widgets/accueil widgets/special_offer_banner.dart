import 'package:flutter/material.dart';
import 'package:socialsafari/pages/offer_details_page.dart';

class SpecialOfferBanner extends StatelessWidget {
  const SpecialOfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // Données de l'offre spéciale
    final Map<String, String> specialOffer = {
      'image': 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1',
      'title': 'Romance à Santorini',
      'rating': '4.8 (2,456 avis)',
      'location': 'Santorini, Grèce',
      'hours': '9:00 - 18:30 (Dernière admission: 17:00)',
      'price': '3800MAD',
      'duration': '5j/4n',
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Offre spéciale',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF11181C),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OfferDetailsPage(offer: specialOffer),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  specialOffer['image']!,
                  width: double.infinity,
                  height: 171,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Text(
                              '4.8 ★',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Text(
                              '5j/4n',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDBD6FF),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          '95% recommandé',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF6D56FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '"Le paradis méditerranéen, des plages magnifiques!"',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
