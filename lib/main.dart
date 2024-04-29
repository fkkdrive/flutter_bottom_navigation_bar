import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigation_bar/with_tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: const WithTabBar(),
      // BasicBottomNavBar(),
    );
  }
}
