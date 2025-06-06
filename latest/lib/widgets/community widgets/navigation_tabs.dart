import 'package:flutter/material.dart';

class NavigationTabs extends StatefulWidget {
  final Function(int) onTabChanged;

  const NavigationTabs({
    super.key,
    required this.onTabChanged,
  });

  @override
  _NavigationTabsState createState() => _NavigationTabsState();
}

class _NavigationTabsState extends State<NavigationTabs> {
  int _selectedIndex = 0;

  final List<String> _tabs = ['Expériences', 'Discussions'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Color(0xFFF9F9F9),
      child: Row(
        children: List.generate(
          _tabs.length,
              (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onTabChanged(index);
              },
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _selectedIndex == index ? Color(0xFF6D56FF) : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: _selectedIndex == index ? Color(0xFF6D56FF) : Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
