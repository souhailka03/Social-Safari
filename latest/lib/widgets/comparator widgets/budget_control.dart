import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class BudgetControl extends StatelessWidget {
  final double budget;
  final double minBudget;
  final double maxBudget;
  final String currency;
  final Function(double) onBudgetChanged;
  final Function(String) onCurrencyChanged;
  final List<String> availableCurrencies;

  const BudgetControl({
    super.key,
    required this.budget,
    required this.minBudget,
    required this.maxBudget,
    required this.currency,
    required this.onBudgetChanged,
    required this.onCurrencyChanged,
    required this.availableCurrencies,
  });

  @override
  Widget build(BuildContext context) {
    final double range = maxBudget - minBudget;
    final int divisions = (range / 100).toInt();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Budget maximum',
                style: AppTextStyles.locationTitle,
              ),
              DropdownButton<String>(
                value: currency,
                items: availableCurrencies.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onCurrencyChanged(newValue);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${budget.toStringAsFixed(0)} $currency',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.primary.withOpacity(0.2),
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withOpacity(0.1),
            ),
            child: Slider(
              value: budget,
              min: minBudget,
              max: maxBudget,
              divisions: divisions,
              label: '${budget.toStringAsFixed(0)} $currency',
              onChanged: onBudgetChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${minBudget.toStringAsFixed(0)} $currency',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              Text(
                '${maxBudget.toStringAsFixed(0)} $currency',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 