import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/auth_controller.dart';
import 'package:job_review/screens/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final String? name;
  final String? email;
  final String? phone;
  final String? refer;
  final String? gender;
  const LoginScreen(
      {super.key, this.name, this.email, this.phone, this.refer, this.gender});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isOtpSent = false;
  String? fcmToken;

  @override
  void initState() {
    super.initState();
    if (widget.phone != null && widget.phone != "") {
      phoneController.text = widget.phone!;
      initFunction();
    }
    () async {
      await setFcmToken();
    }();
    if (mounted) {
      setState(() {});
    }
  }

  initFunction() async {
    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter phone number');
      return;
    }
    var sign = await authController.signup(phoneController.text);
    if (sign != false) {
      setState(() => isOtpSent = true);
      Get.snackbar('Success', 'Otp Sent Successfully $sign');
      //Get.to(() => const LoginScreen());
    } else {
      //  Get.snackbar('alert', 'otp sent failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      //   resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFD7F6E3)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Overlay coins and effects
          Positioned.fill(
            child: Image.asset(
              'assets/images/money_hand.png',
              fit: BoxFit.cover,
            ),
          ),

          // Top Text
          const Positioned(
            top: 60,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Start Your\nEarning.",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        _buildTextField("Mobile Number", phoneController, false,
                            isNumber: true),
                        if (isOtpSent) const SizedBox(height: 12),
                        // if (isOtpSent)
                        //   _buildTextField("Enter otp", otpController),
                        if (isOtpSent) ...[
                          _buildTextField("Enter otp", otpController, true),
                          const SizedBox(height: 2),
                          Align(
                            alignment: FractionalOffset.centerRight,
                            child: TextButton(
                              onPressed: () {
                                initFunction();
                              },
                              child: const Text(
                                "Resend OTP",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],

                        const SizedBox(height: 8),
                        Obx(() {
                          return (authController.isLoginLoading.value)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : (isOtpSent)
                                  ? InkWell(
                                      onTap: () async {
                                        if (fcmToken == null) {
                                          await setFcmToken()
                                              .then((onValue) async {
                                            var token =
                                                await authController.login(
                                              widget.name ?? "",
                                              widget.email ?? "",
                                              phoneController.text,
                                              widget.gender ?? "Male",
                                              fcmToken ?? "",
                                              widget.refer,
                                              otpController.text,
                                            );
                                            if (token != null && token != "") {
                                              Get.offAll(() =>
                                                  const BottomNavigationBarScreen());
                                            } else {}
                                          });
                                        } else {
                                          var token =
                                              await authController.login(
                                            widget.name ?? "",
                                            widget.email ?? "",
                                            phoneController.text,
                                            widget.gender ?? "Male",
                                            fcmToken ?? "",
                                            widget.refer,
                                            otpController.text,
                                          );
                                          if (token != null && token != "") {
                                            Get.offAll(() =>
                                                const BottomNavigationBarScreen());
                                          } else {}
                                        }
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 46,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF8BE68D),
                                              Color(0xFF47C273)
                                            ],
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Log In",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: initFunction,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Send OTP",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    );
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, controller, autofocus,
      {bool isNumber = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: TextFormField(
        controller: controller,
        autofocus: autofocus,
        style: const TextStyle(color: blackColor),
        maxLength: isNumber ? 10 : 6,
        cursorColor: blackColor,
        decoration: InputDecoration(
          counterText: "",
          isDense: true,
          hintText: hint,
          hintStyle: const TextStyle(color: blackColor, fontSize: 13),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future<void> setFcmToken() async {
    String? newFcmToken = await FirebaseMessaging.instance.getToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('fcmToken', newFcmToken ?? '');
    setState(() {
      fcmToken = prefs.getString('fcmToken') ?? '';
    });
  }
}
