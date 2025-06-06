import 'package:flutter/material.dart';

class ActiveFilters extends StatelessWidget {
  final Map<String, Map<String, dynamic>> activeFilters;
  final Function(String) onRemoveFilter;

  const ActiveFilters({
    super.key,
    required this.activeFilters,
    required this.onRemoveFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (activeFilters.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filtres actifs',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  for (final filter in activeFilters.keys) {
                    onRemoveFilter(filter);
                  }
                },
                child: const Text(
                  'Tout réinitialiser',
                  style: TextStyle(
                    color: Color(0xFF6D56FF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: activeFilters.entries.map((entry) {
              return _buildFilterChip(entry.key, entry.value);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filterType, Map<String, dynamic> filter) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF6D56FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF6D56FF),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getFilterLabel(filterType, filter),
            style: const TextStyle(
              color: Color(0xFF6D56FF),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => onRemoveFilter(filterType),
            child: const Icon(
              Icons.close,
              size: 16,
              color: Color(0xFF6D56FF),
            ),
          ),
        ],
      ),
    );
  }

  String _getFilterLabel(String filterType, Map<String, dynamic> filter) {
    switch (filterType) {
      case 'Budget':
        return '${filter['minPrice']?.toInt() ?? 0} - ${filter['maxPrice']?.toInt() ?? 0} MAD';
      case 'Sécurité':
        final options = filter.entries
            .where((e) => e.value == true)
            .map((e) => e.key)
            .join(', ');
        return options.isNotEmpty ? options : '';
      case 'Accessibilité':
        final options = filter.entries
            .where((e) => e.value == true)
            .map((e) => e.key)
            .join(', ');
        return options.isNotEmpty ? options : '';
      case 'Ambiance':
        final options = filter.entries
            .where((e) => e.value == true)
            .map((e) => e.key)
            .join(', ');
        return options.isNotEmpty ? options : '';
      default:
        return '';
    }
  }
} 