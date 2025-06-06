import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'login.dart';

class OfferDetailsPage extends StatefulWidget {
  final Map<String, String> offer;

  const OfferDetailsPage({
    super.key,
    required this.offer,
  });

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  GoogleMapController? mapController;
  late LatLng _location;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Déterminer la localisation en fonction du titre
    _location = _getLocationFromTitle(widget.offer['title'] ?? '');
    _markers.add(
      Marker(
        markerId: const MarkerId('location'),
        position: _location,
        infoWindow: InfoWindow(
          title: widget.offer['title'] ?? '',
        ),
      ),
    );
  }

  LatLng _getLocationFromTitle(String title) {
    // Map des coordonnées pour chaque lieu
    final Map<String, LatLng> locations = {
      'Romance à Santorini, Grèce': const LatLng(36.3932, 25.4615),
      'Évasion insolite à Marrakech': const LatLng(31.6295, -7.9811),
      'Séjour luxueux aux Maldives': const LatLng(3.2028, 73.2207),
      'Vacances de rêve à Dubaï': const LatLng(25.2048, 55.2708),
      'Aventure luxueuse au Costa Rica': const LatLng(9.9281, -84.0907),
      'L\'étoile des Cévennes': const LatLng(44.3432, 3.6013),
    };

    // Retourner les coordonnées correspondantes ou une position par défaut
    return locations[title] ?? const LatLng(0, 0);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.share, size: 20, color: Colors.black),
              onPressed: () {},
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.favorite_border, size: 20, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image principale
                Image.network(
                  widget.offer['image']!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),

                // Contenu principal
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre
                      Text(
                        widget.offer['title'] ?? 'Château de Versailles',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Note
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                                  (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.offer['rating'] ?? '4.8 (2,456 avis)',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Localisation
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.offer['location'] ?? "Place d'Armes, 78000 Versailles, France",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Horaires
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ouvert',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.offer['hours'] ?? '9:00 - 18:30 (Dernière admission: 17:00)',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Prix
                      Text(
                        'À partir de ${widget.offer['price']} Mad par personne',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const Text(
                        'Gratuit pour les moins de 18 ans',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Section Localisation
                      const Text(
                        'Localisation',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _location,
                            zoom: 15,
                          ),
                          markers: _markers,
                          mapType: MapType.normal,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          myLocationButtonEnabled: false,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Ouvrir Google Maps avec le titre de l'offre
                          final searchQuery = Uri.encodeComponent(widget.offer['title'] ?? '');
                          final url = 'https://www.google.com/maps/search/?api=1&query=$searchQuery';
                          // Vous devrez ajouter url_launcher package pour ouvrir l'URL
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[100],
                          foregroundColor: Colors.black87,
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.map_outlined,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text('Voir sur la carte'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Section Avis
                      _buildReviewSection(),

                      // Espace pour le bouton flottant
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, -4),
                    blurRadius: 16,
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: MediaQuery.of(context).padding.bottom + 12,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        offerDetails: widget.offer,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6D56FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Réserver maintenant',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReviewItem(
          'Sophie Dubois',
          'Il y a 2 jours',
          'Une visite extraordinaire ! Les jardins sont magnifiques et le château est tout simplement époustouflant. Je recommande vivement la visite guidée.',
        ),
        const SizedBox(height: 16),
        _buildReviewItem(
          'Pierre Martin',
          'Il y a 1 semaine',
          'La Galerie des Glaces est impressionnante ! Conseil : venez tôt le matin pour éviter la foule.',
        ),
      ],
    );
  }

  Widget _buildReviewItem(String name, String time, String comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[200],
              child: const Icon(
                Icons.person_outline,
                color: Colors.grey,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          comment,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
