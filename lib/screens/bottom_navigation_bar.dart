import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/constant/string_const.dart';
import 'package:job_review/controller/home_controller.dart';
import 'package:job_review/screens/home/homeScreen.dart';
import 'package:job_review/screens/refer_screen.dart';
import 'package:job_review/screens/setting/setting.dart';
import 'package:job_review/screens/setting/submitted_history_screen.dart';
import 'package:job_review/widget/exit_dialog.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navBarItem = [];
    var navBody = [
      const HomeScreen(),
      const ReferEarnScreen(),
      const SubmitHistoryScreen(),
      const SettingScreen()
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: appColor,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            backgroundColor: whiteColor,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/bottom/home.png",
                    fit: BoxFit.cover,
                    height: 24,
                    color:
                        controller.currentNavIndex.value == 0 ? appColor : null,
                  ),
                  label: home),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    controller.currentNavIndex.value == 1
                        ? "assets/bottom/reffer1.png"
                        : "assets/bottom/reffer.png",
                    fit: BoxFit.cover,
                    height: 24,
                    // color:
                    //     controller.currentNavIndex.value == 1 ? appColor : null,
                  ),
                  label: refer),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    controller.currentNavIndex.value == 2
                        ? "assets/bottom/history1.png"
                        : "assets/bottom/history.png",
                    fit: BoxFit.cover,
                    height: 24,
                    // color:
                    //     controller.currentNavIndex.value == 2 ? appColor : null,
                  ),
                  label: wallet),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    controller.currentNavIndex.value == 3
                        ? "assets/bottom/setting1.png"
                        : "assets/bottom/setting.png",
                    fit: BoxFit.cover,
                    height: 24,
                    // color:
                    //     controller.currentNavIndex.value == 3 ? appColor : null,
                  ),
                  label: setting)
            ],
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
        body: Column(
          children: [
            Obx(() => Expanded(
                  child: navBody.elementAt(
                    controller.currentNavIndex.value,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
