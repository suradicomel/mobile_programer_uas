import './screens/home_screen.dart';
import './utils/theme.dart';
import 'package:pendaftaran_baru/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:pendaftaran_baru/screens/payment_screen.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigationScreen(), // atau HomeScreen()
    );
  }
}
