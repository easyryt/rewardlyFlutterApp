import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/screens/bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Advertisement',
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarScreen(),
    );
  }
}
