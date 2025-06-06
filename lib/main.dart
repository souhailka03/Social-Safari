import 'package:flutter/material.dart';
import 'widgets/main_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6D56FF),
          primary: const Color(0xFF6D56FF),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainLayout(),
    );
  }
}