import 'package:flutter/material.dart';
import '../widgets/accueil widgets/advanced_search_bar.dart';
import '../widgets/accueil widgets/filter_panel.dart';
import '../widgets/decouverte widgets/location_card.dart';

class SearchResultsPage extends StatefulWidget {
  final String initialQuery;
  final List<String> recentSearches;
  final List<String> trendingSearches;
  final List<String> recommendedSearches;

  const SearchResultsPage({
    super.key,
    required this.initialQuery,
    required this.recentSearches,
    required this.trendingSearches,
    required this.recommendedSearches,
  });

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final TextEditingController _searchController = TextEditingController();
  final Map<String, List<String>> _filterOptions = {
    'Budget': ['Économique', 'Moyen', 'Luxe'],
    'Type': ['Plage', 'Montagne', 'Ville', 'Campagne'],
    'Activités': ['Culture', 'Sport', 'Gastronomie', 'Shopping'],
    'Saison': ['Été', 'Hiver', 'Printemps', 'Automne'],
  };
  Map<String, List<String>> _activeFilters = {};
  bool _showFilterPanel = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initialQuery;
  }

  List<LocationCard> _getAllLocations() {
    return [
      LocationCard(
        imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/eef712589111312df5d01a548bc438c323bd1bfc',
        location: 'Nice, Côte d\'Azur',
        rating: 4.8,
        description: 'Un endroit magique où la mer rencontre la culture. La promenade des Anglais est simplement magnifique!',
        price: 'À partir de 1500MAD/nuit',
        author: 'Marouane Didi',
      ),
      LocationCard(
        imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/c14f3d4c8f4646ceeaa076ffd380a02fd88b8eda',
        location: 'Gordes, Provence',
        rating: 4.9,
        description: 'Les champs de lavande sont à couper le souffle. L\'authenticité du village est préservée.',
        price: 'À partir de 1800MAD/nuit',
        author: 'Sami Dadah',
        isFavorite: true,
      ),
      LocationCard(
        imageUrl: 'https://a.travel-assets.com/findyours-php/viewfinder/images/res70/481000/481844-Bordeaux.jpg',
        location: 'Bordeaux, Nouvelle-Aquitaine',
        rating: 4.7,
        description: 'Un mélange parfait de tradition et de modernité. Les vignobles de la région sont incontournables.',
        price: 'À partir de 1600MAD/nuit',
        author: 'Amina L.',
      ),
      LocationCard(
        imageUrl: 'https://cdn.britannica.com/41/182741-050-C7EFCCFD/Baron-Haussmann-modernization-plan-areas-boulevards-addition.jpg',
        location: 'Paris, Île-de-France',
        rating: 5.0,
        description: 'La ville de l\'amour et de la lumière. Explorez ses monuments emblématiques comme la Tour Eiffel et le Louvre.',
        price: 'À partir de 2200MAD/nuit',
        author: 'Jean-Paul R.',
        isFavorite: true,
      ),
      LocationCard(
        imageUrl: 'https://www.campsited.com/wp-content/uploads/2019/10/Best-Things-to-Do-in-the-Auvergne-Rhone-Alpes-Region-1-1139x504.jpeg',
        location: 'Lyon, Auvergne-Rhône-Alpes',
        rating: 4.6,
        description: 'Le centre gastronomique de la France, avec ses célèbres bouchons et sa cuisine raffinée.',
        price: 'À partir de 1700MAD/nuit',
        author: 'Lucas M.',
      ),
      LocationCard(
        imageUrl: 'https://live.staticflickr.com/3699/11007453583_7c331e9e1a_b.jpg',
        location: 'Aix-en-Provence, Provence-Alpes-Côte d\'Azur',
        rating: 4.7,
        description: 'Un cadre idyllique entre montagnes et champs de lavande, parfait pour les amoureux de la nature.',
        price: 'À partir de 1800MAD/nuit',
        author: 'Sophie L.',
      ),
      LocationCard(
        imageUrl: 'https://aujourdhui.ma/wp-content/uploads/2022/04/marrakech.png',
        location: 'Marrakech, Marrakech-Safi',
        rating: 4.8,
        description: 'Une ville vibrante où la culture et la tradition se rencontrent. Explorez les souks et la médina historique.',
        price: 'À partir de 1000MAD/nuit',
        author: 'Ahmed B.',
      ),
      LocationCard(
        imageUrl: 'https://f2.hespress.com/wp-content/uploads/2023/11/Chefchaouen.jpg',
        location: 'Chefchaouen, Tanger-Tétouan-Al Hoceïma',
        rating: 4.9,
        description: 'La perle bleue du Maroc. Profitez des montagnes et des ruelles pittoresques baignées dans un bleu magique.',
        price: 'À partir de 950MAD/nuit',
        author: 'Leila H.',
      ),
      LocationCard(
        imageUrl: 'https://www.h24info.ma/wp-content/uploads/2021/05/medina-fe%CC%80s-trtw.jpg',
        location: 'Fès, Fès-Meknès',
        rating: 4.7,
        description: 'Une ville historique avec des médinas classées au patrimoine mondial. Plongez dans l\'histoire marocaine à travers ses artisans et monuments.',
        price: 'À partir de 1100MAD/nuit',
        author: 'Youssef Z.',
      ),
      LocationCard(
        imageUrl: 'https://les-prestigieuses.com/wp-content/uploads/2023/09/plage-taghazout-agadir-surf-scaled.jpg',
        location: 'Agadir, Souss-Massa',
        rating: 4.6,
        description: 'Une destination balnéaire magnifique avec des plages dorées et une promenade animée. Idéale pour les amateurs de plage et de détente.',
        price: 'À partir de 1200MAD/nuit',
        author: 'Hicham K.',
      ),
      LocationCard(
        imageUrl: 'https://media-cdn.tripadvisor.com/media/photo-s/01/6c/0d/6b/getlstd-property-photo.jpg',
        location: 'Sydney, Australia',
        rating: 4.7,
        description: 'Explorez des hôtels de luxe, des plages d\'élite et une scène culinaire mondiale.',
        price: 'À partir de 3300MAD/nuit',
        author: 'James O.',
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1505236230660-0d6d1a5f9c7f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80',
        location: 'Santorini, Greece',
        rating: 4.8,
        description: 'Profitez de villas de luxe avec vue sur la mer, des spas et une cuisine méditerranéenne raffinée.',
        price: 'À partir de 3000MAD/nuit',
        author: 'Maria K.',
      ),
      LocationCard(
        imageUrl: 'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/1d/5e/66.jpg',
        location: 'Rio de Janeiro, Brazil',
        rating: 4.6,
        description: 'Admirez le Christ Rédempteur, des plages luxueuses et une vie nocturne élégante.',
        price: 'À partir de 2200MAD/nuit',
        author: 'Carlos P.',
      ),
      LocationCard(
        imageUrl: 'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg',
        location: 'Monte Carlo, Monaco',
        rating: 4.9,
        description: 'Plongez dans le luxe avec des casinos, des yachts et des hôtels de prestige sur la Côte d\'Azur.',
        price: 'À partir de 4500MAD/nuit',
        author: 'Sophie G.',
      ),
      LocationCard(
        imageUrl: 'https://media-cdn.tripadvisor.com/media/photo-s/01/6c/0d/6b/getlstd-property-photo.jpg',
        location: 'Dubai, UAE',
        rating: 4.8,
        description: 'Vivez le luxe ultime avec des hôtels 7 étoiles, des plages privées et des attractions somptueuses.',
        price: 'À partir de 5000MAD/nuit',
        author: 'Fatima K.',
      ),
      LocationCard(
        imageUrl: 'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/1d/5e/66.jpg',
        location: 'Cape Town, South Africa',
        rating: 4.9,
        description: 'Profitez de vues sur Table Mountain, de vignobles prestigieux et de luxe africain raffiné.',
        price: 'À partir de 2600MAD/nuit',
        author: 'Zandi N.',
      ),
      LocationCard(
        imageUrl: 'https://www.touropia.com/gfx/d/travel-destinations-in-africa/merzouga_sahara_desert.jpg',
        location: 'Merzouga, Drâa-Tafilalet',
        rating: 4.8,
        description: 'Vivez une expérience unique dans le désert du Sahara avec des campements de luxe sous les étoiles.',
        price: 'À partir de 1500MAD/nuit',
        author: 'Mohammed A.',
      ),
      LocationCard(
        imageUrl: 'https://media-cdn.tripadvisor.com/media/photo-s/01/6c/0d/6b/getlstd-property-photo.jpg',
        location: 'London, UK',
        rating: 4.7,
        description: 'Explorez des palaces, des restaurants étoilés et l\'histoire riche de cette capitale mondiale.',
        price: 'À partir de 2900MAD/nuit',
        author: 'Oliver W.',
      ),
      LocationCard(
        imageUrl: 'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg',
        location: 'Nice, France',
        rating: 4.6,
        description: 'Une ville côtière élégante avec des plages de luxe, des hôtels 5 étoiles et une vie nocturne chic.',
        price: 'À partir de 2700MAD/nuit',
        author: 'Pierre L.',
      ),
      LocationCard(
        imageUrl: 'https://media-cdn.tripadvisor.com/media/photo-s/01/6c/0d/6b/getlstd-property-photo.jpg',
        location: 'New York, USA',
        rating: 4.8,
        description: 'Découvrez l\'effervescence de Manhattan, ses restaurants étoilés et ses vues iconiques.',
        price: 'À partir de 3500MAD/nuit',
        author: 'Emma S.',
      ),
      LocationCard(
        imageUrl: 'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/1d/5e/66.jpg',
        location: 'Tokyo, Japan',
        rating: 4.7,
        description: 'Une métropole vibrante mêlant modernité et tradition, avec une cuisine et une culture uniques.',
        price: 'À partir de 2500MAD/nuit',
        author: 'Hiroshi T.',
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80',
        location: 'Venice, Italy',
        rating: 4.8,
        description: 'Explorez les canaux pittoresques, les palais historiques et la magie de cette ville flottante.',
        price: 'À partir de 2800MAD/nuit',
        author: 'Luca R.',
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80',
        location: 'Paris, France',
        rating: 4.9,
        description: 'La ville des lumières, avec ses musées, sa gastronomie et son ambiance romantique inégalée.',
        price: 'À partir de 3000MAD/nuit',
        author: 'Clara D.',
      ),
      LocationCard(
        imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1a/3d/0b/0d/caption.jpg?w=1200&h=-1&s=1',
        location: 'Essaouira, Marrakech-Safi',
        rating: 4.6,
        description: 'Une ville portuaire charmante avec des remparts historiques, des plages et une brise océane rafraîchissante.',
        price: 'À partir de 1000MAD/nuit',
        author: 'Sara T.',
      ),
      LocationCard(
        imageUrl: 'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/1d/5e/66.jpg',
        location: 'Casablanca, Casablanca-Settat',
        rating: 4.7,
        description: 'Une métropole moderne avec la mosquée Hassan II et une scène culinaire dynamique, parfaite pour un séjour sophistiqué.',
        price: 'À partir de 1400MAD/nuit',
        author: 'Amine B.',
      ),
      LocationCard(
        imageUrl: 'https://cdn.getyourguide.com/img/location/5e4b1b5f8c6e3.jpeg/88.jpg',
        location: 'Marrakech, Marrakech-Safi',
        rating: 4.8,
        description: 'Découvrez les souks vibrants, les palais royaux et les jardins luxuriants de la ville rouge du Maroc.',
        price: 'À partir de 1300MAD/nuit',
        author: 'Fatima M.',
      ),
      LocationCard(
        imageUrl: 'https://les-prestigieuses.com/wp-content/uploads/2023/09/plage-taghazout-agadir-surf-scaled.jpg',
        location: 'Agadir, Souss-Massa',
        rating: 4.6,
        description: 'Une destination balnéaire magnifique avec des plages dorées et une promenade animée. Idéale pour les amateurs de plage et de détente.',
        price: 'À partir de 1200MAD/nuit',
        author: 'Hicham K.',
      ),
      LocationCard(
        imageUrl: 'https://www.h24info.ma/wp-content/uploads/2021/05/medina-fe%CC%80s-trtw.jpg',
        location: 'Fès, Fès-Meknès',
        rating: 4.7,
        description: 'Une ville historique avec des médinas classées au patrimoine mondial. Plongez dans l\'histoire marocaine à travers ses artisans et monuments.',
        price: 'À partir de 1100MAD/nuit',
        author: 'Youssef Z.',
      ),
      LocationCard(
        imageUrl: 'https://f2.hespress.com/wp-content/uploads/2023/11/Chefchaouen.jpg',
        location: 'Chefchaouen, Tanger-Tétouan-Al Hoceïma',
        rating: 4.9,
        description: 'La perle bleue du Maroc. Profitez des montagnes et des ruelles pittoresques baignées dans un bleu magique.',
        price: 'À partir de 950MAD/nuit',
        author: 'Leila H.',
      ),
    ];
  }

  List<LocationCard> _getFilteredLocations() {
    final searchText = _searchController.text.toLowerCase();
    final locations = _getAllLocations();

    return locations.where((location) {
      // Filtre par texte de recherche
      final matchesSearch = searchText.isEmpty ||
          location.location.toLowerCase().contains(searchText) ||
          location.description.toLowerCase().contains(searchText) ||
          location.author.toLowerCase().contains(searchText);

      // Filtre par budget
      final matchesBudget = _activeFilters['Budget']?.isEmpty ?? true ||
          _activeFilters['Budget']!.any((budget) {
            final price = int.parse(location.price.replaceAll(RegExp(r'[^0-9]'), ''));
            switch (budget) {
              case 'Économique':
                return price < 1000;
              case 'Moyen':
                return price >= 1000 && price < 2000;
              case 'Luxe':
                return price >= 2000;
              default:
                return false;
            }
          });

      // Filtre par type
      final matchesType = _activeFilters['Type']?.isEmpty ?? true ||
          _activeFilters['Type']!.any((type) {
            switch (type) {
              case 'Plage':
                return location.description.toLowerCase().contains('plage') ||
                    location.description.toLowerCase().contains('balnéaire');
              case 'Montagne':
                return location.description.toLowerCase().contains('montagne');
              case 'Ville':
                return location.description.toLowerCase().contains('ville') ||
                    location.description.toLowerCase().contains('médina');
              case 'Campagne':
                return location.description.toLowerCase().contains('campagne') ||
                    location.description.toLowerCase().contains('nature');
              default:
                return false;
            }
          });

      return matchesSearch && matchesBudget && matchesType;
    }).toList();
  }

  void _handleSearch(String text) {
    setState(() {
      _searchController.text = text;
    });
  }

  void _handleFiltersChanged(Map<String, List<String>> filters) {
    setState(() {
      _activeFilters = filters;
    });
  }

  void _toggleFilterPanel() {
    setState(() {
      _showFilterPanel = !_showFilterPanel;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredLocations = _getFilteredLocations();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Résultats de recherche'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _toggleFilterPanel,
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AdvancedSearchBar(
                    onSearch: _handleSearch,
                    recentSearches: widget.recentSearches,
                    trendingSearches: widget.trendingSearches,
                    recommendedSearches: widget.recommendedSearches,
                  ),
                ),
                if (_activeFilters.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _activeFilters.entries.expand((entry) {
                        return entry.value.map((value) => Chip(
                          label: Text('${entry.key}: $value'),
                          onDeleted: () {
                            setState(() {
                              _activeFilters[entry.key]!.remove(value);
                              if (_activeFilters[entry.key]!.isEmpty) {
                                _activeFilters.remove(entry.key);
                              }
                            });
                          },
                        ));
                      }).toList(),
                    ),
                  ),
                // Section des résultats
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Résultats pour "${_searchController.text}"',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (filteredLocations.isEmpty)
                        const Center(
                          child: Text(
                            'Aucun résultat trouvé',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      else
                        Column(
                          children: List.generate(
                            (filteredLocations.length / 2).ceil(),
                                (rowIndex) {
                              final startIndex = rowIndex * 2;
                              final endIndex = (startIndex + 2).clamp(0, filteredLocations.length);
                              final rowCards = filteredLocations.sublist(startIndex, endIndex);

                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: rowCards.length > 0 ? rowCards[0] : const SizedBox(),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: rowCards.length > 1 ? rowCards[1] : const SizedBox(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                // Suggestions supplémentaires
                if (widget.trendingSearches.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Les utilisateurs recherchent aussi...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.trendingSearches.map((search) =>
                              ActionChip(
                                label: Text(search),
                                onPressed: () => _handleSearch(search),
                              ),
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (_showFilterPanel)
            Positioned(
              right: 16,
              top: 80,
              child: FilterPanel(
                filterOptions: _filterOptions,
                onFiltersChanged: _handleFiltersChanged,
                initialFilters: _activeFilters,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 