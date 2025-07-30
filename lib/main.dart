import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:job_review/screens/auth/splash.dart';
import 'package:job_review/services/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Advertisement',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
