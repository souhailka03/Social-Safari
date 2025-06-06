import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdvancedSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final List<String> recentSearches;
  final List<String> trendingSearches;
  final List<String> recommendedSearches;
  final Function()? onFilterPressed;

  const AdvancedSearchBar({
    Key? key,
    required this.onSearch,
    this.recentSearches = const [],
    this.trendingSearches = const [],
    this.recommendedSearches = const [],
    this.onFilterPressed,
  }) : super(key: key);

  @override
  State<AdvancedSearchBar> createState() => _AdvancedSearchBarState();
}

class _AdvancedSearchBarState extends State<AdvancedSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isListening = false;
  bool _showSuggestions = false;
  List<String> _filteredSuggestions = [];



  void _onFocusChange() {
    setState(() {
      _showSuggestions = _focusNode.hasFocus;
    });
  }

  void _onTextChanged(String text) {
    setState(() {
      _filteredSuggestions = [
        ...widget.recentSearches,
        ...widget.trendingSearches,
        ...widget.recommendedSearches,
      ].where((suggestion) =>
          suggestion.toLowerCase().contains(text.toLowerCase())
      ).toList();
    });
  }



  void _clearSearch() {
    _controller.clear();
    setState(() {
      _filteredSuggestions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: _onTextChanged,
                  onSubmitted: widget.onSearch,
                  decoration: InputDecoration(
                    hintText: 'Rechercher une destination...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF6D56FF)),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_controller.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear, color: Color(0xFF6D56FF)),
                            onPressed: _clearSearch,
                          ),

                      ],
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              if (widget.onFilterPressed != null)
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Color(0xFF6D56FF)),
                  onPressed: widget.onFilterPressed,
                ),
            ],
          ),
        ),
        if (_showSuggestions && _filteredSuggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
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
                if (widget.recentSearches.isNotEmpty)
                  _buildSuggestionSection('Recherches récentes', widget.recentSearches),
                if (widget.trendingSearches.isNotEmpty)
                  _buildSuggestionSection('Tendances', widget.trendingSearches),
                if (widget.recommendedSearches.isNotEmpty)
                  _buildSuggestionSection('Recommandations', widget.recommendedSearches),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSuggestionSection(String title, List<String> suggestions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ...suggestions.map((suggestion) => ListTile(
          leading: const Icon(Icons.history, color: Colors.grey),
          title: Text(suggestion),
          onTap: () {
            _controller.text = suggestion;
            widget.onSearch(suggestion);
          },
        )).toList(),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
} 