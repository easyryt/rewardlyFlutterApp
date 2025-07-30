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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/auth_controller.dart';
import 'package:job_review/widget/coin_chart.dart';
import 'package:job_review/widget/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    initFunction();
  }

  initFunction() async {
    await authController.getEmpProfile();
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sidhart Gupta",
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
                    const Spacer(),
                    // Container(
                    //   padding: const EdgeInsets.all(6),
                    //   decoration: BoxDecoration(
                    //     color: whiteColor,
                    //     borderRadius: BorderRadius.circular(6),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: greyColor.withOpacity(0.3),
                    //         blurRadius: 1.0,
                    //         spreadRadius: 0.5,
                    //       )
                    //     ],
                    //   ),
                    //   child: const Center(
                    //     child: Icon(
                    //       CupertinoIcons.bell_fill,
                    //       color: blackColor,
                    //     ),
                    //   ),
                    // ),
                    Image.asset(
                      "assets/images/notification.png",
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
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
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
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
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Earn Money",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                "Thursday,20 June 2025 (Task)",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  color: greyColor,
                                  height: 1.0,
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: blackColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Filter",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.filter_list,
                                    color: whiteColor,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      const CoinLineChart(),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TaskList(),
                const SizedBox(height: 10),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
