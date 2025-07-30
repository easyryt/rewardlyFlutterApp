import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/api_end_points.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/auth_controller.dart';
import 'package:job_review/controller/main_app_controller.dart';
import 'package:job_review/screens/auth/main_login.dart';
import 'package:job_review/screens/bottom_navigation_bar.dart';
import 'package:job_review/services/global.dart';
import 'package:path_provider/path_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.put(AuthController());
  MainApplicationController mainApplicationController =
      Get.put(MainApplicationController());

  late PersistCookieJar cookieJar;

  Future<void> checkLoginStatus() async {
    final dir = await getApplicationDocumentsDirectory();
    cookieJar = PersistCookieJar(
      storage: FileStorage("${dir.path}/.cookies"),
    );

    // Load cookies for your domain
    List<Cookie> cookies = await cookieJar.loadForRequest(
      Uri.parse(ApiEndpoints.baseUrl),
    );

    // Check if token cookie exists
    final tokenCookie = cookies.firstWhere(
      (cookie) => cookie.name == 'x-user-token',
      orElse: () => Cookie('', ''),
    );

    if (tokenCookie.name.isNotEmpty && tokenCookie.value.isNotEmpty) {
      // ✅ Token cookie exists
      Get.offAll(() => BottomNavigationBarScreen());
    } else {
      // ❌ Token not found, go to login
      Get.offAll(() => MainLogin());
    }
  }

  @override
  @override
  void initState() {
    checkLoginStatus();
    //  checkFirstSeen();
    super.initState();
  }

  checkFirstSeen() async {
    if (Global.storageServices.getString("x-user-token") != null) {
      print(Global.storageServices.getString("x-user-token"));
      await Global.apiClient
          .updateHeader(Global.storageServices.getString("x-user-token"));
      Timer(const Duration(milliseconds: 1300), () async {
        Get.offAll(() => const BottomNavigationBarScreen());
      });
    } else {
      Timer(const Duration(milliseconds: 1300), () async {
        Get.offAll(() => MainLogin());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor.withOpacity(0.93),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: const Center(child: Text("Splash")),
        // child: const Image(
        //   image: AssetImage("assets/images/splash.gif"),
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
