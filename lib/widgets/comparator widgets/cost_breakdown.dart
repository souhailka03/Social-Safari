import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class CostBreakdown extends StatelessWidget {
  final Map<String, dynamic> destination;
  final String currency;

  const CostBreakdown({
    super.key,
    required this.destination,
    required this.currency,
  });

  // Fonction utilitaire pour convertir les valeurs en double
  double _toDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    }
    return 0.0;
  }

  // Obtenir le coût total
  double _getTotalCost() {
    return _toDouble(destination['flightCost']) +
        _toDouble(destination['hotelCost']) +
        _toDouble(destination['localTransport']) +
        _toDouble(destination['activities']) +
        _toDouble(destination['food']);
  }

  @override
  Widget build(BuildContext context) {
    final totalCost = _getTotalCost();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Répartition des coûts',
          style: AppTextStyles.locationTitle,
        ),
        const SizedBox(height: 16),
        _buildCostItem(
          'Vol',
          _toDouble(destination['flightCost']),
          totalCost,
          Icons.flight,
        ),
        _buildCostItem(
          'Hôtel',
          _toDouble(destination['hotelCost']),
          totalCost,
          Icons.hotel,
        ),
        _buildCostItem(
          'Transport local',
          _toDouble(destination['localTransport']),
          totalCost,
          Icons.directions_bus,
        ),
        _buildCostItem(
          'Activités',
          _toDouble(destination['activities']),
          totalCost,
          Icons.attractions,
        ),
        _buildCostItem(
          'Restauration',
          _toDouble(destination['food']),
          totalCost,
          Icons.restaurant,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${totalCost.toStringAsFixed(0)} $currency',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCostItem(
      String label,
      double cost,
      double totalCost,
      IconData icon,
      ) {
    final percentage = totalCost > 0 ? (cost / totalCost * 100) : 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(label),
                ],
              ),
              Text(
                '${cost.toStringAsFixed(0)} $currency (${percentage.toStringAsFixed(1)}%)',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: totalCost > 0 ? cost / totalCost : 0.0,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ],
      ),
    );
  }
} 