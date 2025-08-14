import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/main_app_controller.dart';

class DetailedHistoryScreen extends StatefulWidget {
  final String appId;
  const DetailedHistoryScreen({super.key, required this.appId});

  @override
  State<DetailedHistoryScreen> createState() => _DetailedHistoryScreenState();
}

class _DetailedHistoryScreenState extends State<DetailedHistoryScreen> {
  final MainApplicationController mainApplicationController = Get.find();
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  initFunction() async {
    await Future.wait(
        [mainApplicationController.getSubmittedSingleApps(widget.appId)]);
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
    Size size = MediaQuery.of(context).size;
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
        title: const Text("Detail",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        actions: [
          const SizedBox(width: 16),
        ],
      ),
      body: Obx(() {
        if (mainApplicationController.isSubmittedSingleLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (mainApplicationController.allSubmittedSingleList.isEmpty) {
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ))
            ],
          ));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: mainApplicationController.allSubmittedSingleList.length,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item =
                mainApplicationController.allSubmittedSingleList[index];

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.appLogo ?? '',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.apps, size: 100),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.name ?? 'App',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.packageName ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Divider(height: 30),
                    _infoRow("Type",
                        (item.type == "cpi") ? "Installed" : "Reviewed"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Status : ",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Text(
                          item.status ?? '-',
                          style: TextStyle(
                              color: _getStatusColor(item.status),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // if (item.status == "rejected")
                    //   Align(
                    //     alignment: Alignment.center,
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           vertical: 8.0, horizontal: 6),
                    //       child: InkWell(
                    //           onTap: () {
                    //             _pickImage(size);
                    //           },
                    //           child: const Text(
                    //             "Re-Submit Your Proof Tap Here",
                    //             style: TextStyle(
                    //                 color: appColor,
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: 16),
                    //           )),
                    //     ),
                    //   ),
                    _infoRow("Reason ", item.verificationReason ?? ""),
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
      }),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title : ",
              style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 6),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  // void _pickImage(size) async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     selectedImage = File(image.path);
  //
  //     setState(() {});
  //     if (selectedImage != null) {
  //       mainApplicationController
  //           .proofSubmit(widget.appId, selectedImage!)
  //           .then((onValue) async {
  //         if (onValue != "") {
  //           Get.snackbar("wow", "you have submit successfully");
  //           await showDialog(
  //             barrierDismissible: false,
  //             context: context,
  //             builder: (BuildContext context) {
  //               return Dialog(
  //                 insetPadding: const EdgeInsets.symmetric(horizontal: 12),
  //                 backgroundColor: Colors.white,
  //                 surfaceTintColor: Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Container(
  //                   padding: const EdgeInsets.all(8),
  //                   height: 340,
  //                   width: size.width,
  //                   child: Column(
  //                     children: [
  //                       const SizedBox(
  //                         height: 180,
  //                         child: Center(
  //                           child: Icon(
  //                             FontAwesomeIcons.medal,
  //                             size: 30,
  //                             color: Colors.amber,
  //                           ),
  //                         ),
  //                       ),
  //                       // Image.asset(
  //                       //   "assets/images/thnku.png",
  //                       //   height: 180,
  //                       //   fit: BoxFit.contain,
  //                       // ),
  //                       const SizedBox(height: 6),
  //                       Text(
  //                         'Thank you for Submitting!',
  //                         style: GoogleFonts.roboto(
  //                           textStyle: const TextStyle(
  //                               color: Colors.black,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w600),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 6),
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 12.0),
  //                         child: Text(
  //                           'Your submitting proof  is in Review after sometime you get your confirmation or prize.',
  //                           style: GoogleFonts.roboto(
  //                             textStyle: const TextStyle(
  //                                 color: Colors.black45,
  //                                 fontSize: 13,
  //                                 fontWeight: FontWeight.w500),
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 6),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           ElevatedButton(
  //                             style: ElevatedButton.styleFrom(
  //                               backgroundColor: Colors.white,
  //                               padding:
  //                                   const EdgeInsets.symmetric(horizontal: 16),
  //                               shape: RoundedRectangleBorder(
  //                                 side: const BorderSide(
  //                                     color: Colors.grey, width: 0.8),
  //                                 borderRadius: BorderRadius.circular(6),
  //                               ),
  //                             ),
  //                             onPressed: () async {
  //                               Get.back();
  //                               Get.back();
  //                             },
  //                             child: Text(
  //                               'Done',
  //                               style: GoogleFonts.roboto(
  //                                 textStyle: const TextStyle(
  //                                     color: Colors.black,
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         }
  //       });
  //     }
  //   }
  // }
}
