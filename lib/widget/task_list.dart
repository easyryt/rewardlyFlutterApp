import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/main_app_controller.dart';
import 'package:job_review/screens/home/details_screen.dart';
import 'package:job_review/screens/view_all.dart';
import 'package:job_review/widget/task_card.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  MainApplicationController mainApplicationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Apps Indu..",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                Text(
                  "Complete Your Task & Earn Money",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: greyColor,
                    height: 1.0,
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () {
                Get.to(() => const ViewAll());
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                child: const Center(
                  child: Text(
                    "View All",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: mainApplicationController.allAppsList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            var task = mainApplicationController.allAppsList[index];
            return InkWell(
                onTap: () {
                  Get.to(() => DetailsScreen(
                        appId: task.sId!,
                      ));
                },
                child: TaskCard(task: task));
          },
        ),
      ],
    );
  }
}
