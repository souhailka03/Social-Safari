import 'package:flutter/material.dart';
import 'filter_modal.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final Map<String, dynamic>? activeFilter;
  final Function(Map<String, dynamic>) onFilterChanged;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.icon,
    this.isActive = false,
    this.activeFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFilterModal(context),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              icon,
              size: 16,
              color: const Color(0xFF6D56FF),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => FilterModal(
          filterType: label,
          onApplyFilter: (filter) {
            onFilterChanged(filter);
          },
        ),
      ),
    );
  }

  String _getFilterSummary() {
    if (activeFilter == null) return '';

    switch (label) {
      case 'Budget':
        return '${activeFilter!['minPrice']?.toInt() ?? 0} - ${activeFilter!['maxPrice']?.toInt() ?? 0} MAD';
      case 'Sécurité':
        final options = activeFilter!.entries
            .where((e) => e.value == true)
            .map((e) => e.key)
            .join(', ');
        return options.isNotEmpty ? options : '';
      case 'Accessibilité':
        final options = activeFilter!.entries
            .where((e) => e.value == true)
            .map((e) => e.key)
            .join(', ');
        return options.isNotEmpty ? options : '';
      case 'Ambiance':
        final options = activeFilter!.entries
            .where((e) => e.value == true)
            .map((e) => e.key)
            .join(', ');
        return options.isNotEmpty ? options : '';
      default:
        return '';
    }
  }
}