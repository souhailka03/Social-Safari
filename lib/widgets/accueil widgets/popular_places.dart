import 'package:flutter/material.dart';
import 'package:socialsafari/pages/offer_details_page.dart';
import '../common/image_with_placeholder.dart';

class PopularPlaces extends StatefulWidget {
  const PopularPlaces({super.key});

  @override
  State<PopularPlaces> createState() => _PopularPlacesState();
}

class _PopularPlacesState extends State<PopularPlaces> {
  final ScrollController _scrollController = ScrollController();
  bool _showLeftArrow = false;
  bool _showRightArrow = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateArrows);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateArrows() {
    setState(() {
      _showLeftArrow = _scrollController.offset > 0;
      _showRightArrow = _scrollController.offset < _scrollController.position.maxScrollExtent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Lieux populaires & tendances',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF11181C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Stack(
            children: [
              SizedBox(
                height: 120,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: places.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final place = places[index];
                    return GestureDetector(
                      onTap: () {
                        final offerData = {
                          'image': place['image']!,
                          'title': place['title']!,
                          'location': place['location']!,
                          'description': place['description']!,
                          'rating': place['rating']!,
                          'hours': place['hours']!,
                          'price': place['price']!,
                        };

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OfferDetailsPage(offer: offerData),
                          ),
                        );
                      },
                      child: Container(
                        width: 135,
                        margin: const EdgeInsets.only(right: 10),
                        child: Stack(
                          children: [
                            ImageWithPlaceholder(
                              imageUrl: place['image']!,
                              width: 135,
                              height: 120,
                              borderRadius: BorderRadius.circular(16),
                              heroTag: 'place_image_${place['image']}',
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(102, 98, 98, 0.61),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      place['title']!,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      place['location']!,
                                      style: const TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      place['description']!,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (_showLeftArrow)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset - 150,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0.9),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF6D56FF),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              if (_showRightArrow)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset + 150,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0.9),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF6D56FF),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
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

final List<Map<String, String>> places = [
  {
    'image': 'https://cdn.builder.io/api/v1/image/assets/TEMP/9b579a8c72b3e2a3fc25c6b909d91c275bf7834b',
    'title': 'Paris Getaway',
    'location': 'Paris, France',
    'description': 'Réduction spéciale disponible',
    'rating': '4.9 (2,345 avis)',
    'hours': '9:00 - 23:00',
    'price': '2500MAD',
  },
  {
    'image': 'https://cdn.builder.io/api/v1/image/assets/TEMP/cb8ae7761808864d7245344b6a9b3fbdbcb65b9b',
    'title': 'Santorini',
    'location': 'Santorini, Greece',
    'description': 'Réduction spéciale disponible',
    'rating': '4.8 (3,456 avis)',
    'hours': '8:00 - 20:00',
    'price': '3800MAD',
  },
  {
    'image': 'https://cdn.builder.io/api/v1/image/assets/TEMP/b2de6981bd471ae4d15fcb9cd4583485c28555b2',
    'title': 'Tokyo',
    'location': 'Tokyo, Japon',
    'description': 'Découvrir Tokyo en nuit',
    'rating': '4.7 (5,678 avis)',
    'hours': '24h/24',
    'price': '4200MAD',
  },
  {
    'image': 'https://th.bing.com/th/id/OIP.ZRQLcRGiP0kn5iXqv1FZVgHaEo?w=306&h=191&c=7&r=0&o=5&pid=1.7',
    'title': 'Eiffel Tower Sunset',
    'location': 'Paris, France',
    'description': 'Vue spectaculaire de la Tour Eiffel au coucher du soleil',
    'rating': '4.9 (4,567 avis)',
    'hours': '10:00 - 23:00',
    'price': '2800MAD',
  },
  {
    'image': 'https://th.bing.com/th/id/OIP.FrwyqpComi1hD7D7y8lbvwHaD4?rs=1&pid=ImgDetMain',
    'title': 'Oia Village',
    'location': 'Santorini, Greece',
    'description': 'Maisons blanches et églises au crépuscule à Oia',
    'rating': '4.8 (3,234 avis)',
    'hours': '8:00 - 21:00',
    'price': '4100MAD',
  },
  {
    'image': 'https://th.bing.com/th/id/OIP.oNTgOXZcmWGcf1Q8V7PMGwHaFO?rs=1&pid=ImgDetMain',
    'title': 'Shinjuku Night',
    'location': 'Tokyo, Japon',
    'description': 'Vie nocturne vibrante dans le quartier de Shinjuku',
    'rating': '4.7 (6,789 avis)',
    'hours': '24h/24',
    'price': '3900MAD',
  },
  {
    'image': 'https://th.bing.com/th/id/R.5ce2826c6776f438b8e52026b3d42092?rik=WZ2tyTGjQELQRg&pid=ImgRaw&r=0',
    'title': 'Kyoto Temples',
    'location': 'Kyoto, Japon',
    'description': 'Découverte des temples anciens et jardins traditionnels',
    'rating': '4.9 (5,432 avis)',
    'hours': '9:00 - 17:00',
    'price': '3500MAD',
  },
];