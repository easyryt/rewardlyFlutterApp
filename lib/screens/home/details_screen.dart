import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/main_app_controller.dart';
import 'package:job_review/screens/setting/submitted_history_screen.dart';
import 'package:job_review/widget/app_install_preview_bottom_sheet.dart';

class DetailsScreen extends StatefulWidget {
  final String appId;
  final String type;
  const DetailsScreen({super.key, required this.appId, required this.type});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  MainApplicationController mainApplicationController = Get.find();
  File? selectedImage;
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
              return Stack(
                children: [
                  Column(
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
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 78.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                style:
                                    TextStyle(color: Colors.pink, fontSize: 10),
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
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Text(
                                  widget.type == "review"
                                      ? 'Review & Earn Money'
                                      : "Install & Earn Money",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
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
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                const Text(
                                  '2-3 Minutes',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
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
                            Text(
                              widget.type == "review"
                                  ? "₹${mainApplicationController.reviewAmount.value}"
                                  : "₹${mainApplicationController.installAmount.value}",
                              style: const TextStyle(
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
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
                                    widget.type == "review"
                                        ? 'Tap the "Review" button below to go to the Play Store.'
                                        : 'Tap the "install" button below to go to the Play Store.',
                                  ),
                                  // _buildInstructionItem(
                                  //   '2',
                                  //   'Install the app and open it. Use it for at least 2-3 minutes.',
                                  // ),
                                  _buildInstructionItem(
                                    '2',
                                    'Give the app they items and give it "5-star rating".',
                                  ),
                                  _buildInstructionItem(
                                    '3',
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
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
                            Row(
                              children: [
                                Container(
                                  width: size.width * 0.45,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: appColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: appColor),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: whiteColor,
                                            surfaceTintColor: whiteColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            title: const Text('Submit Proof'),
                                            content: const Text(
                                              'To receive your reward, please upload a screenshot of the installed app from the Play Store. Make sure the screenshot clearly shows the app is installed.',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close dialog
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close dialog first
                                                  _pickImage(
                                                      size); // Trigger image picker
                                                },
                                                child: const Text('Submit'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      backgroundColor: whiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Submit Proof',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: size.width * 0.45,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: appColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: appColor),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (task.packageName != null) {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(16)),
                                          ),
                                          builder: (context) =>
                                              AppInstallPreviewBottomSheet(
                                            packageName: task.packageName!,
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      backgroundColor: whiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.type == "review"
                                            ? 'Review'
                                            : "Install",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    return (mainApplicationController.isProofLoading.value)
                        ? const Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ))
                        : SizedBox();
                  })
                ],
              );
            },
          );
        }));
  }

  void _pickImage(size) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);

      setState(() {});
      if (selectedImage != null) {
        mainApplicationController
            .proofSubmit(widget.appId, selectedImage!)
            .then((onValue) async {
          if (onValue != "") {
            Get.snackbar("wow", "you have submit successfully");
            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 12),
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 340,
                    width: size.width,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 164,
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.medal,
                              size: 60,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        // Image.asset(
                        //   "assets/images/thnku.png",
                        //   height: 180,
                        //   fit: BoxFit.contain,
                        // ),
                        const SizedBox(height: 6),
                        Text(
                          'Thank you for Submitting!',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            'Your submitting proof  is in Review after sometime you get your confirmation or prize.',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.grey, width: 0.8),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () async {
                                Get.to(() => const SubmitHistoryScreen())
                                    ?.then((onValue) {
                                  if (mounted) {
                                    Get.back();
                                    Get.back();
                                  }
                                });
                              },
                              child: Text(
                                'Done',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 12),
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 268,
                    width: size.width,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.warning,
                              size: 60,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        // Image.asset(
                        //   "assets/images/thnku.png",
                        //   height: 180,
                        //   fit: BoxFit.contain,
                        // ),
                        const SizedBox(height: 6),
                        Text(
                          'Submitting Error!',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            'Uploaded image looks like a shared/not genuine image. Please upload original screenshot from device gallery.',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.grey, width: 0.8),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () async {
                                Get.back();
                              },
                              child: Text(
                                'OK',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        });
      }
    }
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
