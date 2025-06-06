import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  final String filterType;
  final Function(Map<String, dynamic>) onApplyFilter;

  const FilterModal({
    super.key,
    required this.filterType,
    required this.onApplyFilter,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  Map<String, dynamic> _selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filtrer par ${widget.filterType}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFilterOptions(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOptions = {};
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Réinitialiser'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApplyFilter(_selectedOptions);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D56FF),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Appliquer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
    switch (widget.filterType) {
      case 'Budget':
        return Column(
          children: [
            _buildRangeSlider(
              min: 0,
              max: 5000,
              divisions: 10,
              label: 'Prix maximum par nuit (MAD)',
              onChanged: (value) {
                setState(() {
                  _selectedOptions['maxPrice'] = value;
                });
              },
            ),
          ],
        );
      case 'Sécurité':
        return Column(
          children: [
            _buildCheckbox(
              'Quartiers sûrs',
              'safeNeighborhoods',
            ),
            _buildCheckbox(
              'Avis positifs sur la sécurité',
              'positiveSecurityReviews',
            ),
            _buildCheckbox(
              'Sécurité 24/7',
              'security24_7',
            ),
          ],
        );
      case 'Accessibilité':
        return Column(
          children: [
            _buildCheckbox(
              'Accès handicapé',
              'wheelchairAccess',
            ),
            _buildCheckbox(
              'Transport public à proximité',
              'publicTransportNearby',
            ),
            _buildCheckbox(
              'Parking disponible',
              'parkingAvailable',
            ),
          ],
        );
      case 'Ambiance':
        return Column(
          children: [
            _buildCheckbox(
              'Calme',
              'quiet',
            ),
            _buildCheckbox(
              'Animé',
              'lively',
            ),
            _buildCheckbox(
              'Familial',
              'familyFriendly',
            ),
            _buildCheckbox(
              'Romantique',
              'romantic',
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildRangeSlider({
    required double min,
    required double max,
    required int divisions,
    required String label,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        RangeSlider(
          values: RangeValues(
            _selectedOptions['minPrice'] ?? min,
            _selectedOptions['maxPrice'] ?? max,
          ),
          min: min,
          max: max,
          divisions: divisions,
          labels: RangeLabels(
            '${_selectedOptions['minPrice']?.toInt() ?? min.toInt()} MAD',
            '${_selectedOptions['maxPrice']?.toInt() ?? max.toInt()} MAD',
          ),
          onChanged: (values) {
            setState(() {
              _selectedOptions['minPrice'] = values.start;
              _selectedOptions['maxPrice'] = values.end;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCheckbox(String label, String key) {
    return CheckboxListTile(
      title: Text(label),
      value: _selectedOptions[key] ?? false,
      onChanged: (value) {
        setState(() {
          _selectedOptions[key] = value;
        });
      },
    );
  }
} 