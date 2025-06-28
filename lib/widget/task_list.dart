import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/model/task_model.dart';
import 'package:job_review/screens/home/details_screen.dart';
import 'package:job_review/screens/view_all.dart';
import 'package:job_review/widget/task_card.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks = [
    TaskModel(
      title: "Job Hai",
      subtitle: "www.jobhai.com",
      reward: "₹7.00",
      action: "Review & Earn Money.",
      imageUrl:
          "https://cdn-1.webcatalog.io/catalog/job-hai/job-hai-icon-unplated.png?v=1714774815279",
      bgColor: const Color(0xFFB7E2E5),
    ),
    TaskModel(
      title: "blinkit",
      subtitle: "www.blinkit.com",
      reward: "₹7.00",
      action: "Review & Earn Money.",
      imageUrl:
          "https://static.toiimg.com/thumb/msid-112400997,width-1280,height-720,imgsize-22628,resizemode-6,overlay-toi_sw,pt-32,y_pad-40/photo.jpg",
      bgColor: const Color(0xFFFEE9AD),
    ),
    TaskModel(
      title: "Dostt",
      subtitle: "www.dostt.com",
      reward: "₹5.00",
      action: "Install & Earn Money.",
      imageUrl:
          "https://play-lh.googleusercontent.com/fO3WP4CNZI0i9TOHG8qWi17_494_ktc1zCor5Nnj3OkFdIz1jsJd4NeAiDutN3kjgOQ",
      bgColor: const Color(0xFFE3C8FF),
    ),
    TaskModel(
      title: "Duolingo",
      subtitle: "www.duolingo.com",
      reward: "₹7.00",
      action: "Review & Earn Money.",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDTbOixDCa6-a9sJ2WaikXnJGqnjm5XA1j9A&s",
      bgColor: const Color(0xFFD9F5C7),
    ),
  ];

  TaskList({super.key});

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
          itemCount: tasks.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Get.to(() => DetailsScreen(task: tasks[index]));
                },
                child: TaskCard(task: tasks[index]));
          },
        ),
      ],
    );
  }
}
