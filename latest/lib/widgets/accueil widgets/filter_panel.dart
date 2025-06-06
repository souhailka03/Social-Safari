import 'package:flutter/material.dart';

class FilterPanel extends StatefulWidget {
  final Map<String, List<String>> filterOptions;
  final Function(Map<String, List<String>>) onFiltersChanged;
  final Map<String, List<String>> initialFilters;

  const FilterPanel({
    super.key,
    required this.filterOptions,
    required this.onFiltersChanged,
    this.initialFilters = const {},
  });

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  late Map<String, List<String>> _selectedFilters;

  @override
  void initState() {
    super.initState();
    _selectedFilters = Map.from(widget.initialFilters);
  }

  void _toggleFilter(String category, String value) {
    setState(() {
      if (!_selectedFilters.containsKey(category)) {
        _selectedFilters[category] = [];
      }
      
      if (_selectedFilters[category]!.contains(value)) {
        _selectedFilters[category]!.remove(value);
        if (_selectedFilters[category]!.isEmpty) {
          _selectedFilters.remove(category);
        }
      } else {
        _selectedFilters[category]!.add(value);
      }
      
      widget.onFiltersChanged(_selectedFilters);
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedFilters.clear();
      widget.onFiltersChanged(_selectedFilters);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filtres',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_selectedFilters.isNotEmpty)
                TextButton(
                  onPressed: _resetFilters,
                  child: const Text('Réinitialiser'),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ...widget.filterOptions.entries.map((entry) {
            final category = entry.key;
            final options = entry.value;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: options.map((option) {
                    final isSelected = _selectedFilters[category]?.contains(option) ?? false;
                    
                    return FilterChip(
                      label: Text(option),
                      selected: isSelected,
                      onSelected: (selected) => _toggleFilter(category, option),
                      backgroundColor: Colors.grey[200],
                      selectedColor: Colors.blue[100],
                      checkmarkColor: Colors.blue,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.blue : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
} 