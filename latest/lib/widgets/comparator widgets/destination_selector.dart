import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class DestinationSelector extends StatelessWidget {
  final List<Map<String, dynamic>> availableDestinations;
  final List<Map<String, dynamic>> selectedDestinations;
  final Function(Map<String, dynamic>) onAddDestination;
  final Function(String) onRemoveDestination;
  final int maxDestinations;

  const DestinationSelector({
    super.key,
    required this.availableDestinations,
    required this.selectedDestinations,
    required this.onAddDestination,
    required this.onRemoveDestination,
    required this.maxDestinations,
  });

  @override
  Widget build(BuildContext context) {
    // Filtrer les destinations disponibles qui ne sont pas déjà sélectionnées
    final availableToSelect = availableDestinations
        .where((dest) => !selectedDestinations
        .any((selected) => selected['id'] == dest['id']))
        .toList();

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
          Text(
            'Destinations sélectionnées (${selectedDestinations.length}/$maxDestinations)',
            style: AppTextStyles.locationTitle,
          ),
          const SizedBox(height: 16),
          if (selectedDestinations.isEmpty)
            Center(
              child: Text(
                'Aucune destination sélectionnée',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedDestinations.map((destination) {
                return Chip(
                  label: Text(destination['name']),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted: () => onRemoveDestination(destination['id']),
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 16),
          if (selectedDestinations.length < maxDestinations && availableToSelect.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: null,
                hint: const Text('Ajouter une destination'),
                isExpanded: true,
                underline: const SizedBox(),
                items: availableToSelect.map((destination) {
                  return DropdownMenuItem<String>(
                    value: destination['id'],
                    child: Text(destination['name']),
                  );
                }).toList(),
                onChanged: (String? selectedId) {
                  if (selectedId != null) {
                    final selectedDestination = availableDestinations
                        .firstWhere((dest) => dest['id'] == selectedId);
                    onAddDestination(selectedDestination);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
} 