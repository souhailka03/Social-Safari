import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class ComparisonCards extends StatelessWidget {
  final List<Map<String, dynamic>> destinations;
  final String currency;

  const ComparisonCards({
    super.key,
    required this.destinations,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    if (destinations.isEmpty) {
      return const Center(
        child: Text('Aucune destination à comparer'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        final destination = destinations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      destination['name'],
                      style: AppTextStyles.locationTitle,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          destination['rating'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildCostRow(
                  'Vol',
                  destination['flightCost'],
                  Icons.flight,
                ),
                const SizedBox(height: 8),
                _buildCostRow(
                  'Hôtel',
                  destination['hotelCost'],
                  Icons.hotel,
                ),
                const SizedBox(height: 8),
                _buildCostRow(
                  'Total',
                  destination['flightCost'] + destination['hotelCost'],
                  Icons.account_balance_wallet,
                  isTotal: true,
                ),
                const SizedBox(height: 16),
                Text(
                  'Points d\'intérêt',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: destination['attractions'].map<Widget>((attraction) {
                    return Chip(
                      label: Text(attraction),
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCostRow(String label, double cost, IconData icon, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isTotal ? AppColors.primary : Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isTotal ? AppColors.primary : Colors.grey[800],
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
        Text(
          '${cost.toStringAsFixed(0)} $currency',
          style: TextStyle(
            color: isTotal ? AppColors.primary : Colors.grey[800],
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
} 