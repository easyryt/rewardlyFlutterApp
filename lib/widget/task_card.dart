import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/main_app_controller.dart';
import 'package:job_review/model/get_all_apps_model.dart';
import 'package:job_review/screens/home/details_screen.dart';

class TaskCard extends StatefulWidget {
  final AllAppsCampaigns task;
  final bool isInstalled;

  const TaskCard({super.key, required this.task, required this.isInstalled});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  MainApplicationController mainApplicationController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IgnorePointer(
      ignoring: widget.task.isLocked ?? false,
      child: Stack(
        children: [
          Opacity(
            opacity: widget.task.isLocked! ? 0.45 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: greyColor.withOpacity(0.15),
                        blurRadius: 1,
                        spreadRadius: 1.5)
                  ]),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 80, right: 10, top: 28, bottom: 4),
                        width: size.width,
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            color: appColor.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.task.name ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, height: 0.75),
                            ),
                            Text(widget.task.status ?? ""),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
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
                            child: (widget.task.appLogo != null &&
                                    widget.task.appLogo!.url != null)
                                ? CachedNetworkImage(
                                    imageUrl: widget.task.appLogo!.url!,
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, error, stackTrace) {
                                      return Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: appColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      );
                                    },
                                  )
                                : Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: appColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (widget.task.type != null &&
                                  widget.task.type == "review")
                              ? "Review & Earn Money"
                              : "Install & Earn Money",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1.0,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on,
                                color: Colors.amber),
                            const SizedBox(width: 8),
                            Obx(() {
                              return Text(
                                widget.task.type != null
                                    ? widget.task.type == "review"
                                        ? "₹${mainApplicationController.reviewAmount.value}"
                                        : "₹${mainApplicationController.installAmount.value}"
                                    : "₹0",
                                style: const TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600),
                              );
                            }),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                // if (task.packageName != null) {
                                //
                                //   showModalBottomSheet(
                                //     context: context,
                                //     isScrollControlled: true,
                                //     backgroundColor: Colors.white,
                                //     shape: const RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.vertical(
                                //           top: Radius.circular(16)),
                                //     ),
                                //     builder: (context) => AppInstallPreviewBottomSheet(
                                //       packageName: task.packageName!,
                                //     ),
                                //   );
                                // }

                                if (widget.task.sId != null &&
                                    widget.task.type != null) {
                                  Get.to(() => DetailsScreen(
                                        appId: widget.task.sId!,
                                        type: widget.task.type!,
                                        isInstalled: widget.isInstalled,
                                        appName: widget.task.name ?? "",
                                      ));
                                }
                              },
                              child: Container(
                                width: 144,
                                padding: EdgeInsets.symmetric(
                                    vertical: widget.isInstalled ? 6 : 4,
                                    horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(28),
                                    bottomRight: Radius.circular(50),
                                    topLeft: Radius.circular(28),
                                    topRight: Radius.circular(50),
                                  ),
                                  border: Border.all(
                                    color: greyColor.withOpacity(0.4),
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                          // widget.task.type == "cpi"
                                          //     ? widget.isInstalled
                                          //         ? "Already Installed"
                                          //         : "Apply Now"
                                          //     :
                                          "Apply Now",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13)),
                                      // if (!widget.isInstalled ||
                                      //     widget.task.type != "cpi")
                                      //   const Spacer(),
                                      // if (!widget.isInstalled ||
                                      //     widget.task.type != "cpi")
                                      Container(
                                        width: 44,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: appColor,
                                        ),
                                        child: const Icon(
                                            Icons.arrow_forward_outlined,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if (widget.task.isLocked!)
            Positioned(
              top: 4,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        size: 13,
                      ),
                      Text(
                        " Campaign Not Start",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
