import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigation_bar/preserving_state.dart';
import 'package:flutter_bottom_navigation_bar/tabbar_demo.dart';
import 'package:flutter_bottom_navigation_bar/with_fab.dart';

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
      home: const PreservingBottomNavState(),
      // WithFabButton(),
      // TabDemo(),
      // WithTabBar(),
      // BasicBottomNavBar(),
    );
  }
}
