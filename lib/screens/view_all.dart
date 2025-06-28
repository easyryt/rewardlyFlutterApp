import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/model/task_model.dart';
import 'package:job_review/screens/home/details_screen.dart';
import 'package:job_review/widget/task_card.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({super.key});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: greyColor.withOpacity(0.3),
                  blurRadius: 1.0,
                  spreadRadius: 0.5,
                )
              ],
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.monetization_on, color: Colors.amber),
                  SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Balance",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: greyColor),
                      ),
                      Text(
                        "₹120.00",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          height: 1.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        itemCount: tasks.length,
        physics: const AlwaysScrollableScrollPhysics(),
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
    );
  }
}
