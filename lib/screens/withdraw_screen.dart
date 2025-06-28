import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';

class WithdrawMoneyScreen extends StatefulWidget {
  const WithdrawMoneyScreen({super.key});

  @override
  State<WithdrawMoneyScreen> createState() => _WithdrawMoneyScreenState();
}

class _WithdrawMoneyScreenState extends State<WithdrawMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();
  final List<int> predefinedAmounts = [100, 200, 300, 500];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        title: const Text(
          'Withdraw',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: greyWhiteColor.withOpacity(0.2),
                      border: Border.all(
                          color: const Color(0xffEEEEEE).withOpacity(0.5),
                          width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: appColor,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sidharth Gupta',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '8888999977',
                                        style: TextStyle(
                                            color: greyColor,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Wallet Balance',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF8B8686),
                                        ),
                                      ),
                                      Text(
                                        '₹109.00',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000),
                                          height: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Enter Amount',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF8B8686),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: blackColor,
                                      width: 1), // Border color
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      '₹',
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Expanded(
                                      // width: 150,
                                      child: TextFormField(
                                        controller: _amountController,
                                        keyboardType: TextInputType.number,
                                        autofocus: false,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter Amount',
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color: Color(0xFF908A8A),
                                              fontSize: 14),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: predefinedAmounts.map((amount) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _amountController.text = amount.toString();
                                });
                              },
                              child: Container(
                                height: 24,
                                width: 64,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: (amount.toString() ==
                                          _amountController.text)
                                      ? appColor.withOpacity(0.05)
                                      : greyColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: (amount.toString() ==
                                              _amountController.text)
                                          ? appColor
                                          : greyColor),
                                ),
                                child: Center(
                                  child: Text(
                                    '+₹$amount',
                                    style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(10),
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
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
