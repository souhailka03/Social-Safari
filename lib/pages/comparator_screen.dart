import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/comparator widgets/destination_selector.dart';
import '../widgets/comparator widgets/budget_control.dart';
import '../widgets/comparator widgets/comparison_chart.dart';
import '../widgets/comparator widgets/comparison_cards.dart';
import '../widgets/comparator widgets/cost_breakdown.dart';
import '../widgets/comparator widgets/destination_comparison_card.dart';

class ComparatorScreen extends StatefulWidget {
  const ComparatorScreen({super.key});

  @override
  State<ComparatorScreen> createState() => _ComparatorScreenState();
}

class _ComparatorScreenState extends State<ComparatorScreen> {
  final List<Map<String, dynamic>> _selectedDestinations = [];
  double _budget = 1000.0;
  String _currency = 'MAD';
  final int _maxDestinations = 3;

  // Définir les constantes pour le budget
  static const double _minBudget = 1000.0;
  static const double _maxBudget = 10000.0;

  final List<Map<String, dynamic>> _availableDestinations = [
    {
      'id': '1',
      'name': 'Paris, France',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT33vLeg1FRMJ30VNtHf6e3BlHWaPuGH8ZHxQ&s',
      'flightCost': 2500.0,
      'hotelCost': 1800.0,
      'localTransport': 500.0,
      'activities': 1200.0,
      'food': 800.0,
      'rating': 4.8,
      'duration': '5-7 jours',
      'bestSeason': 'Printemps',
      'attractions': ['Tour Eiffel', 'Louvre', 'Notre-Dame'],
    },
    {
      'id': '2',
      'name': 'Tokyo, Japan',
      'image': 'https://cdn.cheapoguides.com/wp-content/uploads/sites/2/2018/10/iStock-472041307-770x515.jpg',
      'flightCost': 3000.0,
      'hotelCost': 2200.0,
      'localTransport': 700.0,
      'activities': 2000.0,
      'food': 1200.0,
      'rating': 4.7,
      'duration': '7-10 jours',
      'bestSeason': 'Automne',
      'attractions': ['Mont Fuji', 'Shibuya', 'Senso-ji'],
    },
    {
      'id': '3',
      'name': 'New York, USA',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHqzvH-_xPZX57JgzjMeQFGrL95vuwBidNAQ&s',
      'flightCost': 2800.0,
      'hotelCost': 2500.0,
      'localTransport': 400.0,
      'activities': 1800.0,
      'food': 1000.0,
      'rating': 4.6,
      'duration': '5-7 jours',
      'bestSeason': 'Automne',
      'attractions': ['Times Square', 'Central Park', 'Statue de la Liberté'],
    },
    {
      'id': '4',
      'name': 'Bali, Indonesia',
      'image': 'https://res.klook.com/image/upload/q_85/c_fill,w_750/v1654586251/blog/wsnqunszlajd5ypjo29l.jpg',
      'flightCost': 2000.0,
      'hotelCost': 1500.0,
      'localTransport': 300.0,
      'activities': 1000.0,
      'food': 600.0,
      'rating': 4.9,
      'duration': '7-10 jours',
      'bestSeason': 'Été',
      'attractions': ['Plages de Kuta', 'Temple d\'Uluwatu', 'Rizières de Tegalalang'],
    },
    {
      'id': '5',
      'name': 'Rome, Italy',
      'image': 'https://www.italyguides.it/templates/roma/images_virtuale/icon-facebook.jpg',
      'flightCost': 2200.0,
      'hotelCost': 1600.0,
      'localTransport': 400.0,
      'activities': 800.0,
      'food': 700.0,
      'rating': 4.8,
      'duration': '5-7 jours',
      'bestSeason': 'Printemps',
      'attractions': ['Colisée', 'Vatican', 'Fontaine de Trevi'],
    },
  ];

  String selectedCurrency = 'MAD'; // Devise par défaut
  double conversionRateToUSD = 0.1; // Exemple de taux de conversion
  double conversionRateToEUR = 0.09; // Exemple de taux de conversion

  double convertToCurrency(double amount, String currency) {
    switch (currency) {
      case 'USD':
        return amount * conversionRateToUSD;
      case 'EUR':
        return amount * conversionRateToEUR;
      default:
        return amount; // MAD par défaut
    }
  }

  void _addDestination(Map<String, dynamic> destination) {
    if (_selectedDestinations.length < _maxDestinations) {
      setState(() {
        _selectedDestinations.add(destination);
      });
    }
  }

  void _removeDestination(String id) {
    setState(() {
      _selectedDestinations.removeWhere((dest) => dest['id'] == id);
    });
  }

  void _updateBudget(double value) {
    setState(() {
      _budget = value.roundToDouble();
    });
  }

  void _changeCurrency(String currency) {
    setState(() {
      _currency = currency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparateur de Voyages'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          DestinationSelector(
            availableDestinations: _availableDestinations,
            selectedDestinations: _selectedDestinations,
            onAddDestination: _addDestination,
            onRemoveDestination: _removeDestination,
            maxDestinations: _maxDestinations,
          ),
          const SizedBox(height: 16),
          BudgetControl(
            budget: _budget,
            minBudget: _minBudget,
            maxBudget: _maxBudget,
            currency: _currency,
            onBudgetChanged: _updateBudget,
            onCurrencyChanged: _changeCurrency,
            availableCurrencies: const ['MAD', 'USD', 'EUR'],
          ),
          if (_selectedDestinations.isNotEmpty) ...[
            const SizedBox(height: 16),
            ComparisonChart(
              destinations: _selectedDestinations,
              currency: _currency,
            ),
            const SizedBox(height: 16),
            ..._selectedDestinations.map((destination) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: DestinationComparisonCard(
                  destination: destination,
                  currency: _currency,
                  onRemove: () => _removeDestination(destination['id']),
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }
} 