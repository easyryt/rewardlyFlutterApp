import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/screens/withdraw_screen.dart';

class WalletScreen extends StatelessWidget {
  final String userName = "Shiddhart Dupta";
  final String userPhone = "8837983099";
  final double balance = 210.00;
  final List<Map<String, dynamic>> transactions = [
    {'date': 'Tuesday, 24 June 2025', 'amount': 100},
    {'date': 'Tuesday, 24 June 2025', 'amount': 150},
    {'date': 'Tuesday, 24 June 2025', 'amount': 100},
    {'date': 'Tuesday, 24 June 2025', 'amount': 200},
    {'date': 'Tuesday, 24 June 2025', 'amount': 200},
  ];

  WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        title: const Text(
          'My Wallet',
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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Wallet Card
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/wallet_back.png",
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    userName,
                    style: const TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    userPhone,
                    style: const TextStyle(
                        color: whiteColor, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${balance.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => WithdrawMoneyScreen());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: whiteColor)),
                          child: const Center(
                            child: Text(
                              "Withdraw",
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      "Earnzy",
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Transaction Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Transaction",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    //  Get.to(() => const ViewAll());
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
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            // Transactions List
            Column(
              children: transactions.map((txn) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: greyWhiteColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        txn['date'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: greyColor,
                        ),
                      ),
                      Text(
                        "₹${txn['amount']}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
