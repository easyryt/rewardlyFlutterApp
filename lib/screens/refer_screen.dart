import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/auth_controller.dart';
import 'package:job_review/controller/main_app_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferEarnScreen extends StatefulWidget {
  const ReferEarnScreen({super.key});

  @override
  State<ReferEarnScreen> createState() => _ReferEarnScreenState();
}

class _ReferEarnScreenState extends State<ReferEarnScreen> {
  AuthController authController = Get.find();
  MainApplicationController mainApplicationController = Get.find();
  final double referralEarnings = 100.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        title: const Text(
          'Refer & Earn',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     size: 18,
        //   ),
        //   onPressed: () {
        //     Get.back();
        //   },
        // ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Image.asset(
              'assets/images/refer_back.png',
              height: 188,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),

            // Card with code and share options
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: greyWhiteColor.withOpacity(0.2),
                border: Border.all(
                    color: const Color(0xffEEEEEE).withOpacity(0.5), width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Invite Your Friend, Earn Coins',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Copy Your Code, Share It With Your Friends',
                                      style: TextStyle(
                                          color: greyColor,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Earnings',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: greyColor),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '₹${mainApplicationController.refWallet.value}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        height: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Referral Code Box

                            Row(
                              children: [
                                Expanded(
                                  child: DottedBorder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 11),
                                    color: appColor,
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(6),
                                    strokeWidth: 1,
                                    dashPattern: [6, 3, 6, 3],
                                    child: Text(
                                      authController.refCode.value,
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F5E9)
                                        .withOpacity(0.3),
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.copy,
                                        color: Colors.green),
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text: authController.refCode.value));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Code copied to clipboard')),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      })),
                  const SizedBox(height: 16),
                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            shareAppWithReferral("message");
                          },
                          child: socialIconButton(Icons.message, Colors.green)),
                      GestureDetector(
                          onTap: () {
                            shareAppWithReferral("fb");
                          },
                          child: socialIconButton(Icons.facebook, Colors.blue)),
                      GestureDetector(
                        onTap: () {
                          shareAppWithReferral("whatsapp");
                        },
                        child: socialIconButton(
                            FontAwesomeIcons.whatsapp, Colors.yellow),
                      ),
                      GestureDetector(
                          onTap: () {
                            shareAppWithReferral("telegram");
                          },
                          child: socialIconButton(Icons.telegram, Colors.blue)),
                      // socialIconButton(Icons.cast_sharp, Colors.black),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Steps
            stepItem('1', 'Send an Invite to a Friend'),
            const SizedBox(height: 12),
            stepItem('2', 'Your Friend Signs Up.'),
            const SizedBox(height: 12),
            stepItem('3',
                'You\'ll Both Get Cash When Your Friend Submits Their First Receipt.'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget socialIconButton(IconData icon, Color color) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color),
    );
  }

  Widget stepItem(String number, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
          color: greyWhiteColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: greyWhiteColor)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: blueColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(number,
                style: const TextStyle(
                    color: blueColor, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          )
        ],
      ),
    );
  }

  void shareAppWithReferral(type) async {
    // final referralCode = authController.refCode.value;
    // const appLink = "https://play.google.com/store/apps/details?id=";
    // final message =
    //     "Hey! Join this amazing app and earn rewards. Use my referral code: $referralCode\n$appLink";
    //
    // Share.share(message, subject: "Join & Earn with me!");
    final code = authController.refCode.value;
    const link = "https://play.google.com/store/apps/details?id=";
    final message = Uri.encodeComponent(
        "Hey! Join this app and earn rewards.\nReferral Code: $code\n$link");
    String? url;
    if (type == "whatsapp") {
      url = "whatsapp://send?text=$message";
      setState(() {});
    } else if (type == "fb") {
      url =
          "fb://facewebmodal/f?href=https://www.facebook.com/sharer/sharer.php?u=$link&quote=$message";
      setState(() {});
    } else if (type == "telegram") {
      url = "tg://msg?text=$message";
      setState(() {});
    } else if (type == "message") {
      url = "sms:?body=$message";
      setState(() {});
    } else {}

    if (url != null) {
      await launchUrl(Uri.parse(url));
    }
  }
}
