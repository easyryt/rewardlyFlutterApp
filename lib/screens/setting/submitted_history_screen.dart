import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/main_app_controller.dart';
import 'package:job_review/screens/setting/submitted_detailed_history_screen.dart';

class SubmitHistoryScreen extends StatefulWidget {
  const SubmitHistoryScreen({super.key});

  @override
  State<SubmitHistoryScreen> createState() => _SubmitHistoryScreenState();
}

class _SubmitHistoryScreenState extends State<SubmitHistoryScreen> {
  final MainApplicationController mainApplicationController = Get.find();

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  initFunction() async {
    await Future.wait([mainApplicationController.getSubmittedAllApps()]);
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "approved":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back_ios,
        //       size: 18,
        //     )),
        title: const Text("History",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        actions: [
          const SizedBox(width: 16),
        ],
      ),
      body: Obx(() {
        if (mainApplicationController.isSubmittedAppsLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (mainApplicationController.allSubmittedAppsList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/no_history.png",
                  fit: BoxFit.cover,
                  height: 350,
                ),
                const Text(
                  "Once you start reviewing or installing apps",
                  style: TextStyle(),
                ),
                const SizedBox(height: 16),
                // TextButton(
                //     onPressed: () {
                //       initFunction();
                //     },
                //     child: const Text(
                //       "Retry",
                //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                //     ))
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: mainApplicationController.allSubmittedAppsList.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = mainApplicationController.allSubmittedAppsList[index];
            return InkWell(
              onTap: () {
                Get.to(() => DetailedHistoryScreen(
                      appId: item.sId!,
                    ));
              },
              child: Card(
                color: whiteColor,
                surfaceTintColor: whiteColor,
                elevation: 2.0,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: item.appLogo != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(item.appLogo!,
                              width: 40, height: 40, fit: BoxFit.cover),
                        )
                      : const Icon(Icons.apps),
                  title: Text(
                    item.name ?? 'Name',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Type: ${item.type ?? '-'}"),
                      Row(
                        children: [
                          const Text("Status: "),
                          Text(
                            item.status ?? '-',
                            style: TextStyle(
                                color: _getStatusColor(item.status),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
