import 'package:flutter/material.dart';

class FilterPanel extends StatefulWidget {
  final Map<String, List<String>> filterOptions;
  final Function(Map<String, List<String>>) onFiltersChanged;
  final Map<String, List<String>> initialFilters;
  final VoidCallback? onClose;

  const FilterPanel({
    super.key,
    required this.filterOptions,
    required this.onFiltersChanged,
    this.initialFilters = const {},
    this.onClose,
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
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.85,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                  Row(
                    children: [
                      if (_selectedFilters.isNotEmpty)
                        TextButton(
                          onPressed: _resetFilters,
                          child: const Text(
                            'Réinitialiser',
                            style: TextStyle(
                              color: Color(0xFF6D56FF),
                            ),
                          ),
                        ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Color(0xFF6D56FF)),
                        onPressed: () {
                          if (widget.onClose != null) {
                            widget.onClose!();
                          }
                        },
                      ),
                    ],
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
                          label: Text(
                            option,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) => _toggleFilter(category, option),
                          backgroundColor: Colors.grey[100],
                          selectedColor: const Color(0xFF6D56FF),
                          checkmarkColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: isSelected ? const Color(0xFF6D56FF) : Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          showCheckmark: false,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
} 