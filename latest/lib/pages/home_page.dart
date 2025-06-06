import 'package:flutter/material.dart';
import '../widgets/accueil widgets/header.dart';
import '../widgets/accueil widgets/category_list.dart';
import '../widgets/accueil widgets/popular_places.dart';
import '../widgets/accueil widgets/special_offer_banner.dart';
import '../widgets/accueil widgets/special_offers.dart';
import '../widgets/accueil widgets/advanced_search_bar.dart';
import '../widgets/accueil widgets/filter_panel.dart';
import '../pages/search_results_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _recentSearches = [
    'Paris, France',
    'Bali, Indonésie',
    'Tokyo, Japon',
  ];

  final List<String> _trendingSearches = [
    'Marrakech, Maroc',
    'Barcelone, Espagne',
    'New York, USA',
  ];

  final List<String> _recommendedSearches = [
    'Venise, Italie',
    'Kyoto, Japon',
    'Sydney, Australie',
  ];

  final Map<String, List<String>> _filterOptions = {
    'Budget': ['Économique', 'Moyen', 'Luxe'],
    'Type': ['Plage', 'Montagne', 'Ville', 'Campagne'],
    'Activités': ['Culture', 'Sport', 'Gastronomie', 'Shopping'],
    'Saison': ['Été', 'Hiver', 'Printemps', 'Automne'],
  };

  Map<String, List<String>> _activeFilters = {};
  String _searchText = '';
  bool _showFilterPanel = false;
  bool _showAllOffers = false;

  void _handleSearch(String text) {
    setState(() {
      _searchText = text;
      if (!_recentSearches.contains(text)) {
        _recentSearches.insert(0, text);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(
          initialQuery: text,
          recentSearches: _recentSearches,
          trendingSearches: _trendingSearches,
          recommendedSearches: _recommendedSearches,
        ),
      ),
    );
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

  void _toggleShowAllOffers() {
    setState(() {
      _showAllOffers = !_showAllOffers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const Header(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: AdvancedSearchBar(
                            onSearch: _handleSearch,
                            recentSearches: _recentSearches,
                            trendingSearches: _trendingSearches,
                            recommendedSearches: _recommendedSearches,
                            onFilterPressed: _toggleFilterPanel,
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
                        const CategoryList(),
                        const PopularPlaces(),
                        const SpecialOfferBanner(),
                        SpecialOffers(
                          showAllOffers: _showAllOffers,
                          onToggleShowAll: _toggleShowAllOffers,
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
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
      ),
    );
  }
}