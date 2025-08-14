import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/main_app_controller.dart';
import 'package:job_review/widget/task_card.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({super.key});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  MainApplicationController mainApplicationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        title: const Text("Apps Indu...",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        actions: [
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          //   margin: const EdgeInsets.symmetric(vertical: 8),
          //   decoration: BoxDecoration(
          //     color: whiteColor,
          //     borderRadius: BorderRadius.circular(6),
          //     boxShadow: [
          //       BoxShadow(
          //         color: greyColor.withOpacity(0.3),
          //         blurRadius: 1.0,
          //         spreadRadius: 0.5,
          //       )
          //     ],
          //   ),
          //   child: const Center(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(Icons.monetization_on, color: Colors.amber),
          //         SizedBox(width: 4),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               "Balance",
          //               style: TextStyle(
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 12,
          //                   color: greyColor),
          //             ),
          //             Text(
          //               "₹120.00",
          //               style: TextStyle(
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 13,
          //                 height: 1.0,
          //               ),
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        itemCount: mainApplicationController.allAppsList.length,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          // var task = mainApplicationController.allAppsList[index];
          return Obx(() {
            var task = mainApplicationController.allAppsList[index];
            bool isInstalled =
                mainApplicationController.installedStatus[task.packageName] ??
                    false;

            return InkWell(
                onTap: () {
                  // if (task.sId != null && task.type != null) {
                  // Get.to(() => DetailsScreen(
                  // appId: task.sId!,
                  // type: task.type!,
                  // ));
                  // }
                  if (isInstalled && task.type == "cpi") {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: whiteColor,
                          surfaceTintColor: whiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: const Text('Installed'),
                          content: Text(
                            'It seems already installed in your device to claim reward uninstall existing ${task.name} app and  Install again by this install option.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: TaskCard(
                  task: task,
                  isInstalled: isInstalled,
                ));
          });
        },
      ),
    );
  }
}
