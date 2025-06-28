import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';

class ReferEarnScreen extends StatelessWidget {
  final String referralCode = 'oTZKigRuPf';
  final double referralEarnings = 100.00;

  const ReferEarnScreen({super.key});

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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          onPressed: () {
            Get.back();
          },
        ),
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
                    child: Column(
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
                                  '₹${referralEarnings.toStringAsFixed(2)}',
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
                                  referralCode,
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
                                color: const Color(0xFFE8F5E9).withOpacity(0.3),
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.copy, color: Colors.green),
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: referralCode));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Code copied to clipboard')),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      socialIconButton(Icons.message, Colors.green),
                      socialIconButton(Icons.facebook, Colors.blue),
                      socialIconButton(Icons.message, Colors.blueGrey),
                      socialIconButton(Icons.telegram, Colors.blue),
                      socialIconButton(Icons.cast_sharp, Colors.black),
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
}
