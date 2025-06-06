import 'package:flutter/material.dart';

import '../../pages/discovery_screen.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 21),
      height: 80, // Increased height to accommodate content
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) => CategoryItem(
            icon: category['icon']!,
            name: category['name']!,
          )).toList(),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String icon;
  final String name;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('Navigating to discovery screen with category: $name');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiscoveryScreen(initialCategory: name),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(99, 74, 255, 0.10),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: Image.network(
                  icon,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C1B1F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> categories = [
  {
    'icon': 'https://cdn.builder.io/api/v1/image/assets/TEMP/23db90245c2f1f73ed7cafc8d53d0ae3271cc2e6',
    'name': 'Loisirs',
  },
  {
    'icon': 'https://cdn.builder.io/api/v1/image/assets/TEMP/adad16b1eb56921cc9a4b43741366732f148cff0',
    'name': 'Aventure',
  },
  {
    'icon': 'https://cdn.builder.io/api/v1/image/assets/TEMP/fcc582ca8c7ad2f6e298e877ced7bba7de03660b',
    'name': 'Culture',
  },
  {
    'icon': 'https://cdn.builder.io/api/v1/image/assets/TEMP/9446f32ba89b3d3ff07a4c542a93ea883012bbcc',
    'name': 'Luxe',
  },
  {
    'icon': 'https://cdn.builder.io/api/v1/image/assets/TEMP/1ff0433dfbc006240e916b2c9e6b7534af481380',
    'name': 'Bien-être',
  },
  {
    'icon': 'https://cdn.builder.io/api/v1/image/assets/TEMP/83f18567976f9317e3f3cadeed2f978814fa6ff8',
    'name': 'En famille',
  },
  {
    'icon': 'https://cdn.builder.io/api/v1/image/assets/TEMP/d4cc8560d7b947f312b2c6015ec756255e183291',
    'name': 'Romantiques',
  },
];