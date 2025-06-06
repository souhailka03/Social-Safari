import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class ComparisonChart extends StatelessWidget {
  final List<Map<String, dynamic>> destinations;
  final String currency;

  const ComparisonChart({
    super.key,
    required this.destinations,
    required this.currency,
  });

  double _getTotalCost(Map<String, dynamic> destination) {
    // Convertir de manière sûre les valeurs en double
    double toDouble(dynamic value) {
      if (value is int) {
        return value.toDouble();
      } else if (value is double) {
        return value;
      }
      return 0.0;
    }

    return toDouble(destination['flightCost']) +
        toDouble(destination['hotelCost']) +
        toDouble(destination['localTransport']) +
        toDouble(destination['activities']) +
        toDouble(destination['food']);
  }

  @override
  Widget build(BuildContext context) {
    if (destinations.isEmpty) {
      return const SizedBox.shrink();
    }

    final double maxTotal = destinations.fold<double>(
      0.0,
          (max, destination) {
        final total = _getTotalCost(destination);
        return total > max ? total : max;
      },
    );

    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 300,
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
          Text(
            'Comparaison des coûts',
            style: AppTextStyles.locationTitle,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxTotal,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.toStringAsFixed(0)} $currency',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value < 0 || value >= destinations.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            destinations[value.toInt()]['name'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(0),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: destinations.asMap().entries.map((entry) {
                  final index = entry.key;
                  final destination = entry.value;
                  final total = _getTotalCost(destination);

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: total,
                        color: AppColors.primary,
                        width: 20,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 