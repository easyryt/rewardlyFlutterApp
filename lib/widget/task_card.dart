import 'package:flutter/material.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/model/get_all_apps_model.dart';

class TaskCard extends StatelessWidget {
  final AllAppsCampaigns task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                    left: 80, right: 10, top: 20, bottom: 4),
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
                      task.name ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, height: 0.75),
                    ),
                    Text(task.status ?? ""),
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
                            color: greyColor.withOpacity(0.5), blurRadius: 0.75)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    // child: Image.network(
                    //   task,
                    //   height: 60,
                    //   width: 60,
                    //   fit: BoxFit.cover,
                    //   errorBuilder: (context, error, stackTrace) {
                    //     return Container(
                    //       height: 60,
                    //       width: 60,
                    //       decoration: BoxDecoration(
                    //           color: appColor,
                    //           borderRadius: BorderRadius.circular(10)),
                    //     );
                    //   },
                    // ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Review & Earn Money",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.amber),
                    const SizedBox(width: 8),
                    Text(
                      "₹7.00",
                      style: const TextStyle(
                          fontSize: 18.5, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Container(
                      width: 144,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Apply Now",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13)),
                            Container(
                              width: 44,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: appColor,
                              ),
                              child: const Icon(Icons.arrow_forward_outlined,
                                  color: Colors.white),
                            ),
                          ],
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
    );
  }
}
