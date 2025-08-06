import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/main_app_controller.dart';
import 'package:job_review/widget/app_install_preview_screen.dart';

class DetailsScreen extends StatefulWidget {
  final String appId;
  const DetailsScreen({super.key, required this.appId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  MainApplicationController mainApplicationController = Get.find();

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  initFunction() async {
    await Future.wait([mainApplicationController.getSingleApps(widget.appId)]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (mainApplicationController.isSingleAppsLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (mainApplicationController.singleAppsList.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Data not available."),
                const SizedBox(height: 16),
                TextButton(
                    onPressed: () {
                      initFunction();
                    },
                    child: const Text(
                      "Retry",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ))
              ],
            ));
          }
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: mainApplicationController.singleAppsList.length,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              var task = mainApplicationController.singleAppsList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 2, right: 10, top: 30, bottom: 4),
                        width: size.width,
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          color: appColor.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 18,
                                    )),
                                const Text("Apps Instruction",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 78.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.name ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        height: 0.75),
                                  ),
                                  Text(task.status ?? ""),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              color: appColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: greyColor.withOpacity(0.5),
                                    blurRadius: 0.75)
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            // child: Container(
                            //   height: 60,
                            //   width: 60,
                            //   decoration: BoxDecoration(
                            //       color: appColor,
                            //       borderRadius: BorderRadius.circular(10)),
                            // ),
                            child: Image.network(
                              task.appLogo!.url!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: appColor.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10)),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "High Rated",
                            style: TextStyle(color: Colors.pink, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Task Details
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/playStore.png",
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Playstore: ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            const Text(
                              'Review & Earn Money',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Image.asset(
                              "assets/images/clock.png",
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Time Required: ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            const Text(
                              '2-3 Minutes',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          'Completing This Task and Earn Money',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          '₹7.00',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 14),

                        const Text(
                          'Read the below instruction carefully.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: greyColor.withOpacity(0.35),
                                blurRadius: 1.0,
                                spreadRadius: 0.5,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildInstructionItem(
                                '1',
                                'Tap the "install App" button below to go to the Play Store.',
                              ),
                              _buildInstructionItem(
                                '2',
                                'Install the app and open it. Use it for at least 2-3 minutes.',
                              ),
                              _buildInstructionItem(
                                '3',
                                'Give the app they items and give it "5-star rating".',
                              ),
                              _buildInstructionItem(
                                '4',
                                'Write a short "positive review" (2-3 lines).',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Note/Warning Section
                        const Text(
                          'Note / Warning',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: greyColor.withOpacity(0.35),
                                blurRadius: 1.0,
                                spreadRadius: 0.5,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildWarningItem(
                                  'Do not uninstall the app before approval.'),
                              _buildWarningItem(
                                  'Fake reviews or screenshots may result in account suspension.'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: appColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: appColor),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppInstallPreviewScreen(
                                    packageName: task.packageName ??
                                        "com.example.default",
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 2),
                              backgroundColor: whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Apply Now',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor,
                                  ),
                                ),
                                Container(
                                  width: 44,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: appColor,
                                  ),
                                  child: const Icon(Icons.arrow_forward,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        }));
  }

  Widget _buildInstructionItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: appColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: appColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.close,
            color: Colors.red,
            size: 18,
            weight: 12,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
