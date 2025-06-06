import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/decouverte widgets/custom_search_bar.dart';
import '../widgets/decouverte widgets/filter_chip.dart' as custom;
import '../widgets/decouverte widgets/category_item.dart';
import '../widgets/decouverte widgets/location_card.dart';
import '../widgets/accueil widgets/header.dart';
import '../widgets/decouverte widgets/active_filters.dart';

class DiscoveryScreen extends StatefulWidget {
  final String? initialCategory;

  const DiscoveryScreen({
    super.key,
    this.initialCategory,
  });

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  late String selectedCategory;
  final Map<String, Map<String, dynamic>> _activeFilters = {};
  String _searchText = '';
  Set<String> favoriteLocations = {};

  // Mapping entre les catégories de la page d'accueil et celles de la page découverte
  final Map<String, String> categoryMapping = {
    'Loisirs': 'Plages',
    'Aventure': 'Aventure',
    'Culture': 'Culture',
    'Luxe': 'Luxe',
    'Bien-être': 'Gastronomie',
    'En famille': 'Plages',
    'Romantiques': 'Romantiques',
  };

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory ?? "Plages";
    debugPrint('DiscoveryScreen initialisé avec la catégorie: $selectedCategory');
  }

  void _handleFilterChanged(String filterType, Map<String, dynamic> filter) {
    setState(() {
      if (filter.isEmpty) {
        _activeFilters.remove(filterType);
      } else {
        _activeFilters[filterType] = filter;
      }
    });
  }

  void _removeFilter(String filterType) {
    setState(() {
      _activeFilters.remove(filterType);
    });
  }

  void _handleSearch(String text) {
    setState(() {
      _searchText = text.toLowerCase();
    });
  }

  bool _matchesSearch(LocationCard card) {
    if (_searchText.isEmpty) return true;

    // Normaliser le texte de recherche
    final searchTerms = _searchText.toLowerCase().split(' ');

    // Créer un texte de recherche complet pour la carte
    final searchableText = [
      card.location.toLowerCase(),
      card.description.toLowerCase(),
      card.author.toLowerCase(),
      card.price.toLowerCase(),
    ].join(' ');

    // Vérifier si tous les termes de recherche sont présents
    return searchTerms.every((term) => searchableText.contains(term));
  }

  Widget _buildFilteredContent(List<LocationCard> cards) {
    final filteredCards = cards.where(_matchesSearch).toList();

    if (filteredCards.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Aucun résultat trouvé',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Essayez d\'autres mots-clés',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: List.generate(
        (filteredCards.length / 2).ceil(),
            (rowIndex) {
          final startIndex = rowIndex * 2;
          final endIndex = (startIndex + 2).clamp(0, filteredCards.length);
          final rowCards = filteredCards.sublist(startIndex, endIndex);

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
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 47,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Retour à la page d'accueil
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                        (route) => false,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
              const Text(
                'Découverte',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 14,
                height: 15,
                child: CustomPaint(
                  painter: NotificationIconPainter(),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 19,
                height: 19,
                decoration: const BoxDecoration(
                  color: Color(0xFFCED0F8),
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/216133e8eea83f5382dba7c712a5a691d784f9b3',
                    width: 19,
                    height: 19,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('DiscoveryScreen build appelé');
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      CustomSearchBar(
                        onSearchChanged: _handleSearch,
                      ),
                      SizedBox(height: 20),
                      _buildFiltersSection(),
                      SizedBox(height: 20),
                      _buildCategoriesSection(),
                      SizedBox(height: 30),
                      _buildCategoryContent(selectedCategory),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Filtres', style: AppTextStyles.title),
        SizedBox(height: 15),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: custom.FilterChipWidget(
                    label: 'Budget',
                    icon: Icons.attach_money,
                    isActive: _activeFilters.containsKey('Budget'),
                    activeFilter: _activeFilters['Budget'],
                    onFilterChanged: (filter) => _handleFilterChanged('Budget', filter),
                  ),
                ),
                SizedBox(width: 19),
                Expanded(
                  child: custom.FilterChipWidget(
                    label: 'Sécurité',
                    icon: Icons.security,
                    isActive: _activeFilters.containsKey('Sécurité'),
                    activeFilter: _activeFilters['Sécurité'],
                    onFilterChanged: (filter) => _handleFilterChanged('Sécurité', filter),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: custom.FilterChipWidget(
                    label: 'Accessibilité',
                    icon: Icons.accessible,
                    isActive: _activeFilters.containsKey('Accessibilité'),
                    activeFilter: _activeFilters['Accessibilité'],
                    onFilterChanged: (filter) => _handleFilterChanged('Accessibilité', filter),
                  ),
                ),
                SizedBox(width: 19),
                Expanded(
                  child: custom.FilterChipWidget(
                    label: 'Ambiance',
                    icon: Icons.mood,
                    isActive: _activeFilters.containsKey('Ambiance'),
                    activeFilter: _activeFilters['Ambiance'],
                    onFilterChanged: (filter) => _handleFilterChanged('Ambiance', filter),
                  ),
                ),
              ],
            ),
          ],
        ),
        if (_activeFilters.isNotEmpty) ...[
          SizedBox(height: 16),
          ActiveFilters(
            activeFilters: _activeFilters,
            onRemoveFilter: _removeFilter,
          ),
        ],
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Catégories', style: AppTextStyles.title),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CategoryItem(
                label: 'Plages',
                icon: Icon(
                    Icons.beach_access, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Plages',
                onTap: () => _onCategorySelected('Plages'),
              ),
            ),
            Expanded(
              child: CategoryItem(
                label: 'Culture',
                icon: Icon(Icons.museum, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Culture',
                onTap: () => _onCategorySelected('Culture'),
              ),
            ),
            Expanded(
              child: CategoryItem(
                label: 'Aventure',
                icon: Icon(Icons.landscape, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Aventure',
                onTap: () => _onCategorySelected('Aventure'),
              ),
            ),
            Expanded(
              child: CategoryItem(
                label: 'Gastronomie',
                icon: Icon(
                    Icons.restaurant, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Gastronomie',
                onTap: () => _onCategorySelected('Gastronomie'),
              ),
            ),
            Expanded(
              child: CategoryItem(
                label: 'Luxe',
                icon: Icon(Icons.star, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Luxe',
                onTap: () => _onCategorySelected('Luxe'),
              ),
            ),
            Expanded(
              child: CategoryItem(
                label: 'Romance',
                icon: Icon(Icons.favorite, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Romantiques',
                onTap: () => _onCategorySelected('Romantiques'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onCategorySelected(String category) {
    setState(() {
      // Utiliser le mapping pour convertir la catégorie si nécessaire
      selectedCategory = categoryMapping[category] ?? category;
      debugPrint('Selected category: $selectedCategory');
    });
  }

  Widget _buildCategoryContent(String category) {
    debugPrint('Building content for category: $category');
    List<LocationCard> cards;

    switch (category) {
      case 'Plages':
        cards = _getPlagesCards();
        break;
      case 'Culture':
        cards = _getCultureCards();
        break;
      case 'Aventure':
        cards = _getAventureCards();
        break;
      case 'Gastronomie':
        cards = _getGastronomieCards();
        break;
      case 'Luxe':
        cards = _getLuxeCards();
        break;
      case 'Romantiques':
        cards = _getRomantiquesCards();
        break;
      default:
        cards = _getPlagesCards();
    }

    return _buildFilteredContent(cards);
  }

  List<LocationCard> _getPlagesCards() {
    return [
      LocationCard(
        imageUrl: 'https://www.cestee.fr/images/02/38/20238-920w.webp',
        location: 'Plage de Palombaggia, Corse',
        rating: 4.9,
        description: 'Située au sud de Porto-Vecchio, cette plage est célèbre pour son sable blanc et ses eaux turquoise cristallines, entourée de pins parasols.',
        price: 'À partir de 2500MAD/nuit',
        author: 'Jean Dupont',
        isFavorite: favoriteLocations.contains('Plage de Palombaggia, Corse'),
        onFavoriteTap: () => _toggleFavorite('Plage de Palombaggia, Corse'),
      ),
      LocationCard(
        imageUrl: 'https://media.routard.com/image/80/6/pays-basque-biarritz.1582806.142.jpg',
        location: 'Plage de la Côte des Basques, Biarritz',
        rating: 4.8,
        description: 'Un spot de surf emblématique offrant une vue imprenable sur les montagnes des Pyrénées et l\'océan Atlantique.',
        price: 'À partir de 2000MAD/nuit',
        author: 'Marie Lefevre',
        isFavorite: favoriteLocations.contains('Plage de la Côte des Basques, Biarritz'),
        onFavoriteTap: () => _toggleFavorite('Plage de la Côte des Basques, Biarritz'),
      ),
      LocationCard(
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTI6dSv8LzE1r2YVWB5xiU9bmADWcmoEljeGw&s',
        location: 'Calanque d\'En-Vau, Cassis',
        rating: 4.7,
        description: 'Nichée entre des falaises calcaires, cette calanque offre des eaux bleu émeraude idéales pour la baignade et le kayak.',
        price: 'À partir de 2300MAD/nuit',
        author: 'Sophie Martin',
        isFavorite: favoriteLocations.contains('Calanque d\'En-Vau, Cassis'),
        onFavoriteTap: () => _toggleFavorite('Calanque d\'En-Vau, Cassis'),
      ),
      LocationCard(
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-0RXh0b2oVLM3MgorMk4nn5cQvgtF2JmErg&s',
        location: 'Plage de l\'Espiguette, Camargue',
        rating: 4.6,
        description: 'Une plage sauvage et préservée s\'étendant sur des kilomètres, caractérisée par ses dunes de sable et son environnement naturel.',
        price: 'À partir de 1800MAD/nuit',
        author: 'Luc Durand',
        isFavorite: favoriteLocations.contains('Plage de l\'Espiguette, Camargue'),
        onFavoriteTap: () => _toggleFavorite('Plage de l\'Espiguette, Camargue'),
      ),
    ];
  }


  List<LocationCard> _getCultureCards() {
    return [
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80',
        location: 'Kyoto, Japan',
        rating: 4.9,
        description: 'Experience the rich cultural heritage of Kyoto with its ancient temples, traditional tea houses, and stunning cherry blossoms.',
        price: 'À partir de 2000MAD/nuit',
        author: 'Hana Tanaka',
        isFavorite: favoriteLocations.contains('Kyoto, Japan'),
        onFavoriteTap: () => _toggleFavorite('Kyoto, Japan'),
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        location: 'Rome, Italy',
        rating: 4.8,
        description: 'Discover the heart of ancient Rome with the Colosseum, Roman Forum, and delectable Italian cuisine.',
        price: 'À partir de 1800MAD/nuit',
        author: 'Luca Rossi',
        isFavorite: favoriteLocations.contains('Rome, Italy'),
        onFavoriteTap: () => _toggleFavorite('Rome, Italy'),
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1520454974749-611b7248ffdb',
        location: 'Nice, Côte d\'Azur',
        rating: 4.8,
        description: 'Un endroit magique où la mer rencontre la culture. La promenade des Anglais est simplement magnifique!',
        price: 'À partir de 1500MAD/nuit',
        author: 'Marouane didi',
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1534430480872-3498386e7856',
        location: 'Gordes, Provence',
        rating: 4.9,
        description: 'Les champs de lavande sont à couper le souffle. L\'authenticité du village est préservée.',
        price: 'À partir de 1800MAD/nuit',
        author: 'Sami dadah',
        isFavorite: true,
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1549144511-f099e773c147',
        location: 'Bordeaux, Nouvelle-Aquitaine',
        rating: 4.7,
        description: 'Un mélange parfait de tradition et de modernité. Les vignobles de la région sont incontournables.',
        price: 'À partir de 1600MAD/nuit',
        author: 'Amina L.',
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1431274172761-fca41d930114',
        location: 'Paris, Île-de-France',
        rating: 5.0,
        description: 'La ville de l\'amour et de la lumière. Explorez ses monuments emblématiques.',
        price: 'À partir de 2200MAD/nuit',
        author: 'Jean-Paul R.',
        isFavorite: true,
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1595846519845-68e298c2edd8',
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
    ];
  }


  List<LocationCard> _getAventureCards() {
    return [
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        location: 'Patagonia, Argentina',
        rating: 4.8,
        description: 'Embark on a thrilling adventure through rugged mountains, glaciers, and pristine wilderness.',
        price: 'À partir de 2200MAD/nuit',
        author: 'Mateo Alvarez',
        isFavorite: favoriteLocations.contains('Patagonia, Argentina'),
        onFavoriteTap: () => _toggleFavorite('Patagonia, Argentina'),
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80',
        location: 'Queenstown, New Zealand',
        rating: 4.9,
        description: 'Experience adrenaline-pumping activities like bungee jumping, skiing, and jet boating in this adventure capital.',
        price: 'À partir de 2500MAD/nuit',
        author: 'Sophie Bennett',
        isFavorite: favoriteLocations.contains('Queenstown, New Zealand'),
        onFavoriteTap: () => _toggleFavorite('Queenstown, New Zealand'),
      ),
    ];
  }

  List<LocationCard> _getGastronomieCards() {
    return [
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        location: 'Paris, France',
        rating: 4.9,
        description: 'Savor world-class French cuisine, from croissants to escargot, in the culinary capital of the world.',
        price: 'À partir de 2000MAD/nuit',
        author: 'Clara Dubois',
        isFavorite: favoriteLocations.contains('Paris, France'),
        onFavoriteTap: () => _toggleFavorite('Paris, France'),
      ),
      LocationCard(
        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        location: 'Tokyo, Japan',
        rating: 4.8,
        description: 'Indulge in sushi, ramen, and kaiseki dining, blending tradition and innovation in every bite.',
        price: 'À partir de 2200MAD/nuit',
        author: 'Yuki Sato',
        isFavorite: favoriteLocations.contains('Tokyo, Japan'),
        onFavoriteTap: () => _toggleFavorite('Tokyo, Japan'),
      ),
    ];
  }

  List<LocationCard> _getLuxeCards() {
    return [
      LocationCard(
        imageUrl: 'https://www.thetraveldaily.co.uk/sites/default/files/styles/content_area_cover/public/field/image/pexels-diego-f-parra-15478194.jpg?itok=a6F0Cp3g',
        location: 'Dubai, UAE',
        rating: 4.9,
        description: 'Indulge in opulent resorts, private beaches, and world-class shopping in this glittering desert oasis.',
        price: 'À partir de 5000MAD/nuit',
        author: 'Aisha Al-Mansoori',
        isFavorite: favoriteLocations.contains('Dubai, UAE'),
        onFavoriteTap: () => _toggleFavorite('Dubai, UAE'),
      ),
      LocationCard(
        imageUrl: 'https://cf.bstatic.com/xdata/images/hotel/max1280x900/287331792.webp?k=1b3b445d2aea1bfba211e348f08d594213e50aa3197c27728da132f9607fcf19&o=',
        location: 'Maldives',
        rating: 4.8,
        description: 'Relax in overwater bungalows, savor gourmet cuisine, and enjoy unparalleled luxury on pristine islands.',
        price: 'À partir de 6000MAD/nuit',
        author: 'Nadia Hassan',
        isFavorite: favoriteLocations.contains('Maldives'),
        onFavoriteTap: () => _toggleFavorite('Maldives'),
      ),
    ];
  }

  List<LocationCard> _getRomantiquesCards() {
    return [
      LocationCard(
        imageUrl: 'https://th.bing.com/th/id/OIP.7NPTZUs2KA9Wxwzay9QulgHaE8?rs=1&pid=ImgDetMain',
        location: 'Venice, Italy',
        rating: 4.9,
        description: 'Drift through the canals on a gondola, dine by candlelight, and fall in love amidst timeless charm.',
        price: 'À partir de 2200MAD/nuit',
        author: 'Isabella Rossi',
        isFavorite: favoriteLocations.contains('Venice, Italy'),
        onFavoriteTap: () => _toggleFavorite('Venice, Italy'),
      ),
      LocationCard(
        imageUrl: 'https://th.bing.com/th/id/R.aea89065604b9b7e4028fa13587eb2ee?rik=fco7v4ksBj5Suw&pid=ImgRaw&r=0',
        location: 'Paris, France',
        rating: 4.8,
        description: 'Stroll hand in hand along the Seine, enjoy a romantic dinner at the Eiffel Tower, and create unforgettable memories.',
        price: 'À partir de 2300MAD/nuit',
        author: 'Sophie Moreau',
        isFavorite: favoriteLocations.contains('Paris, France'),
        onFavoriteTap: () => _toggleFavorite('Paris, France'),
      ),
    ];
  }

  void _toggleFavorite(String location) {
    setState(() {
      if (favoriteLocations.contains(location)) {
        favoriteLocations.remove(location);
      } else {
        favoriteLocations.add(location);
      }
    });
  }
}