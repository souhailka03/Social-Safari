import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 1),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(231, 223, 223, 0.5),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Container(
              width: 21,
              height: 21,
              decoration: BoxDecoration(
                color: const Color(0xFF6D56FF),
                borderRadius: BorderRadius.circular(21),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 14,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Où souhitez-vous aller ?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF11181C),
                    ),
                  ),
                  Text(
                    'Cherchez des destinations, des expériences...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ],
              ),
            ),
            Image.network(
              'https://cdn.builder.io/api/v1/image/assets/TEMP/856a0980cd33dba3fde712bb374ed57daa70a149',
              width: 16,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}