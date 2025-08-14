// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:job_review/constant/color_const.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<Color> gradientColors = [
//     appColor,
//     greyColor,
//   ];
//
//   bool showAvg = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(children: [
//       Container(height: 100, width: 300, color: Colors.red),
//       // CoinLineChart(),
//       const SizedBox(
//         height: 10,
//       ),
//       Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           const CoinLineChart(),
//           // ...List.generate(5, (i) {
//           //   double leftOffset = i * 55;
//           //   return Positioned(
//           //     top: -4,
//           //     left: leftOffset,
//           //     child: Column(
//           //       children: [
//           //         Image.asset('assets/bottom/home.png',
//           //             height: 14), // your coin icon
//           //         Text('₹${[5, 10, 6, 8, 12][i]}',
//           //             style: const TextStyle(fontWeight: FontWeight.bold)),
//           //       ],
//           //     ),
//           //   );
//           // }
//           //),
//         ],
//       ),
//
//       Container(height: 60, width: 300, color: Colors.green),
//       SizedBox(height: 10),
//
//       Container(height: 30, width: 250, color: Colors.red),
//     ]));
//   }
// }
//
// class CoinLineChart extends StatelessWidget {
//   const CoinLineChart({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final coinValues = [5.0, 10.0, 6.0, 8.0, 12.0];
//     return AspectRatio(
//       aspectRatio: 2.5,
//       child: LineChart(
//         LineChartData(
//           titlesData: const FlTitlesData(show: false),
//           gridData: const FlGridData(show: false),
//           borderData: FlBorderData(show: false),
//           // lineTouchData: const LineTouchData(enabled: false),
//           lineTouchData: LineTouchData(
//             enabled: false,
//             // getTouchedSpotIndicator: (barData, spotIndexes) =>
//             //     spotIndexes.map((index) {
//             //   return TouchedSpotIndicatorData(
//             //     FlLine(color: Colors.transparent),
//             //     FlDotData(show: false),
//             //   );
//             // }).toList(),
//             // touchTooltipData: LineTouchTooltipData(
//             //   // tooltipBgColor: Colors.transparent,
//             //   tooltipPadding: EdgeInsets.zero,
//             //   tooltipMargin: 0,
//             //   getTooltipItems: (spots) => spots.map((spot) {
//             //     return LineTooltipItem(
//             //       '₹${spot.y.toInt()}',
//             //       const TextStyle(
//             //         fontWeight: FontWeight.bold,
//             //         color: Colors.black,
//             //       ),
//             //       children: [],
//             //     );
//             //   }).toList(),
//             // ),
//             // handleBuiltInTouches: false,
//           ),
//
//           showingTooltipIndicators: [
//             ShowingTooltipIndicators(List.generate(coinValues.length, (index) {
//               return LineBarSpot(
//                 LineChartBarData(
//                   spots: List.generate(coinValues.length,
//                       (i) => FlSpot(i.toDouble(), coinValues[i])),
//                 ), // same barData
//                 0, // bar index
//                 FlSpot(index.toDouble(), coinValues[index]),
//               );
//             })),
//           ],
//           lineBarsData: [
//             LineChartBarData(
//               spots: List.generate(coinValues.length,
//                   (i) => FlSpot(i.toDouble(), coinValues[i])),
//               isCurved: true,
//               dotData: FlDotData(
//                 show: true,
//                 getDotPainter: (spot, percent, barData, index) {
//                   return FlDotCirclePainter(
//                     radius: 4,
//                     color: Colors.white,
//                     strokeColor: Colors.green,
//                     strokeWidth: 2,
//                   );
//                 },
//               ),
//               belowBarData: BarAreaData(
//                 show: true,
//                 gradient: LinearGradient(
//                   colors: [Colors.green.withOpacity(0.3), Colors.white],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               color: Colors.green,
//               barWidth: 3,
//             ),
//
//             // 🟡 Optional future (greyed out) line
//             LineChartBarData(
//               spots: [
//                 const FlSpot(4, 12),
//                 const FlSpot(4.8, 9),
//                 const FlSpot(6, 12)
//               ],
//               isCurved: true,
//               dotData: const FlDotData(show: false),
//               belowBarData: BarAreaData(show: false),
//               color: Colors.grey.shade400,
//               barWidth: 2,
//               dashArray: [5, 5],
//             ),
//           ],
//           extraLinesData: const ExtraLinesData(),
//           minX: 0,
//           maxX: 6,
//           minY: 0,
//           maxY: 15,
//         ),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/auth_controller.dart';
import 'package:job_review/controller/main_app_controller.dart';
import 'package:job_review/screens/auth/profile_screen.dart';
import 'package:job_review/widget/task_list.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.find();
  MainApplicationController mainApplicationController = Get.find();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));

    await initFunction();
    _refreshController.refreshCompleted();
    // setState(() {});
  }

  void onLoading() async {
    await Future.delayed(const Duration(microseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    initFunction();
    SmartRefresher(
      controller: _refreshController,
    );
  }

  initFunction() async {
    await Future.wait([
      authController.getEmpProfile(),
      mainApplicationController.getRewardAmount(),
      mainApplicationController.getAllAnalytics(),
      mainApplicationController.getAllApps()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home_back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(child: Obx(() {
          if (mainApplicationController.isAppsLoading.value &&
              mainApplicationController.allAppsList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SmartRefresher(
              enablePullDown: true,
              // enablePullUp: true,
              controller: _refreshController,
              onRefresh: onRefresh,
              onLoading: onLoading,
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ProfileScreen());
                        },
                        child: Row(
                          children: [
                            const SizedBox(width: 2),
                            Container(
                              padding: const EdgeInsets.all(5),
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
                                child: Icon(
                                  Icons.person,
                                  color: blackColor,
                                  size: 28,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authController.nameUser.value,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                Text(
                                  "Welcome Back",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: appColor,
                                    fontFamily: "inter",
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),

                      // Image.asset(
                      //   "assets/images/notification.png",
                      //   height: 40,
                      //   fit: BoxFit.cover,
                      // ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/balance_back.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/coin.png",
                                height: 28,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Balance",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: greyColor),
                                  ),
                                  Text(
                                    "₹${authController.wallet.value}",
                                    style: const TextStyle(
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
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Obx(() {
                    if (mainApplicationController.bannerList.isEmpty) {
                      return const Center(child: Text(""));
                      //  child: Text("No Banner Image available"));
                    }
                    return Stack(
                      children: [
                        SizedBox(
                          height: 120,
                          width: double.infinity,
                          // child: PageView.builder(
                          //   onPageChanged: (index) {
                          //     mainApplicationController
                          //         .changeSliderIndex(index);
                          //   },
                          //   itemCount:
                          //       mainApplicationController.bannerList.length,
                          //   itemBuilder: (context, index) {
                          //     return Container(
                          //       margin: const EdgeInsets.symmetric(
                          //           horizontal: 12),
                          //       decoration: BoxDecoration(
                          //         // color: Colors.red,
                          //         borderRadius: BorderRadius.circular(10),
                          //         image: DecorationImage(
                          //           image: NetworkImage(
                          //               mainApplicationController
                          //                       .bannerList[index]
                          //                   ["bannerImg"][0]["url"]),
                          //           fit: BoxFit.cover,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          child: CarouselSlider(
                            items: mainApplicationController.bannerList
                                .map((banner) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                        image: NetworkImage(banner['url']!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // child: Image.network(
                                    //   banner['bannerImg'][0]["url"],
                                    //   fit: BoxFit.cover,
                                    // ),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                                height: 120.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 2000),
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    mainApplicationController
                                        .currentIndex.value = index;
                                  });
                                }),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 8,
                          // child: Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: List.generate(
                          //       mainApplicationController.bannerList.length,
                          //       (index) {
                          //     return Obx(() {
                          //       return Container(
                          //         margin: const EdgeInsets.symmetric(
                          //             horizontal: 4.0),
                          //         width: mainApplicationController
                          //                     .currentIndex.value ==
                          //                 index
                          //             ? 6
                          //             : 4,
                          //         height: mainApplicationController
                          //                     .currentIndex.value ==
                          //                 index
                          //             ? 6
                          //             : 4,
                          //         decoration: BoxDecoration(
                          //           color: mainApplicationController
                          //                       .currentIndex.value ==
                          //                   index
                          //               ? Constants.primaryColor
                          //               : Colors.grey[400],
                          //           shape: BoxShape.circle,
                          //         ),
                          //       );
                          //     });
                          //   }),
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                mainApplicationController.bannerList.map((url) {
                              int index = mainApplicationController.bannerList
                                  .indexOf(url);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: mainApplicationController
                                              .currentIndex.value ==
                                          index
                                      ? const Color.fromRGBO(0, 0, 0, 0.9)
                                      : const Color.fromRGBO(0, 0, 0, 0.4),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    );
                  }),
                  // const SizedBox(height: 10),
                  // const AnalyticsScreen(),
                  // Container(
                  //   padding: const EdgeInsets.all(10),
                  //   margin:
                  //       const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                  //   decoration: BoxDecoration(
                  //     color: whiteColor,
                  //     borderRadius: BorderRadius.circular(6),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: greyColor.withOpacity(0.35),
                  //         blurRadius: 1.0,
                  //         spreadRadius: 0.5,
                  //       )
                  //     ],
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           const Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "Your Earn Money",
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.w600, fontSize: 15),
                  //               ),
                  //               Text(
                  //                 "Thursday,20 June 2025 (Task)",
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.w500,
                  //                   fontSize: 11,
                  //                   color: greyColor,
                  //                   height: 1.0,
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //           Container(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 4),
                  //             decoration: BoxDecoration(
                  //                 color: blackColor,
                  //                 borderRadius: BorderRadius.circular(6)),
                  //             child: const Center(
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text(
                  //                     "Filter",
                  //                     style: TextStyle(
                  //                         color: whiteColor,
                  //                         fontWeight: FontWeight.w500,
                  //                         fontSize: 12),
                  //                   ),
                  //                   SizedBox(width: 8),
                  //                   InkWell(
                  //                     child: Icon(
                  //                       Icons.filter_list,
                  //                       color: whiteColor,
                  //                       size: 18,
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //       const SizedBox(height: 6),
                  //       const CoinLineChart(),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 18),
                  (mainApplicationController.allAppsList.isEmpty)
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 80),
                            const Text("Apps not available."),
                            const SizedBox(height: 4),
                            TextButton(
                                onPressed: () {
                                  initFunction();
                                },
                                child: const Text(
                                  "Retry",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: appColor),
                                ))
                          ],
                        ))
                      : const TaskList(),
                  const SizedBox(height: 10),
                ]),
              ),
            ),
          );
        })),
      ),
    );
  }
}
//
// class AnalyticsScreen extends StatelessWidget {
//   const AnalyticsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     MainApplicationController mainApplicationController = Get.find();
//
//     return Obx(() {
//       final data = mainApplicationController.getAnalyticsModel.value;
//       if (data == null) {
//         return const Center(child: SizedBox());
//       }
//
//       final earnings = data.earnings;
//       final activity = data.activity;
//
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Earnings Card
//           _sectionTitle("Earnings"),
//           Card(
//             color: whiteColor,
//             surfaceTintColor: whiteColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   _earningRow("Total Balance", earnings?.totalEarnings),
//                   const Divider(),
//                   _earningRow("Self Wallet", earnings?.selfWallet),
//                   _earningRow("Referral Wallet", earnings?.referralWallet),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   Widget _sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
//
//   Widget _earningRow(String label, int? value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style:
//                   const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
//           Text(
//             "₹${value ?? 0}",
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: appColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _activityCard(String title, Cpi? cpi, Color color) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 3,
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             Text(title,
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, color: color, fontSize: 16)),
//             const SizedBox(height: 8),
//             _activityStat("Approved", cpi?.approved),
//             _activityStat("Rejected", cpi?.rejected),
//             _activityStat("Submitted", cpi?.submitted),
//             _activityStat("Pending", cpi?.pending),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _activityStat(String label, int? value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label),
//           Text(
//             value?.toString() ?? "0",
//             style: const TextStyle(fontWeight: FontWeight.w600),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Example Controller
// class AnalyticsController extends GetxController {
//   Rx<GetAnalyticsModel?> getAnalyticsModel = Rx<GetAnalyticsModel?>(null);
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchAnalytics();
//   }
//
//   void fetchAnalytics() {
//     // TODO: replace with API call
//     getAnalyticsModel.value = GetAnalyticsModel(
//       earnings: Earnings(
//         selfWallet: 1200,
//         referralWallet: 800,
//         totalEarnings: 2000,
//         referralBreakdown: ["John - ₹500", "Jane - ₹300"],
//       ),
//       activity: Activity(
//         cpi: Cpi(approved: 5, rejected: 1, submitted: 7, pending: 2),
//         review: Cpi(approved: 3, rejected: 0, submitted: 5, pending: 1),
//       ),
//     );
//   }
// }
