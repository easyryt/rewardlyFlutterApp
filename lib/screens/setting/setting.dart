import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/auth_controller.dart';
import 'package:job_review/screens/auth/main_login.dart';
import 'package:job_review/screens/auth/profile_screen.dart';
import 'package:path_provider/path_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AuthController authController = Get.find();

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        elevation: 0,
        // leading: InkWell(
        //   onTap: (){
        //     Navigator.pop(context);
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.all(8),
        //     decoration: BoxDecoration(
        //       color: whiteColor,
        //       borderRadius: BorderRadius.circular(6),
        //       boxShadow: [
        //         BoxShadow(
        //           color: greyColor.withOpacity(0.2),
        //           blurRadius: 1.0,
        //           spreadRadius: 0.5,
        //         )
        //       ],
        //     ),
        //     child: const Center(
        //       child: Icon(
        //         Icons.arrow_back_ios,
        //         color: blackColor,
        //         size: 16,
        //       ),
        //     ),
        //   ),
        // ),
        automaticallyImplyLeading: false,
        title: const Text(
          'Setting',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: blackColor,
            fontFamily: "Roboto",
          ),
        ),

        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: greyColor.withOpacity(0.2),
                  blurRadius: 1.0,
                  spreadRadius: 0.5,
                )
              ],
            ),
            child: const Center(
              child: Icon(
                CupertinoIcons.bell_fill,
                color: blackColor,
                size: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: greyColor.withOpacity(0.15),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SETTINGS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(() {
                        return InkWell(
                          onTap: () {
                            Get.to(() => const ProfileScreen());
                          },
                          child: _settingsTile(
                            context,
                            title: (authController.nameUser.value != "")
                                ? authController.nameUser.value
                                : 'Profile',
                            leading: CircleAvatar(
                              radius: 13,
                              backgroundColor: appColor,
                              child: Center(
                                child: Text(
                                  (authController.nameUser.value != "")
                                      ? authController.nameUser.value
                                          .substring(0, 1)
                                          .toUpperCase()
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: whiteColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      Obx(() {
                        return (authController.emailUser.value != "")
                            ? Column(
                                children: [
                                  const SizedBox(height: 14),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const ProfileScreen());
                                    },
                                    child: _settingsTile(context,
                                        title: authController.emailUser.value,
                                        leading: Icon(
                                          Icons.email,
                                          size: 24,
                                          color: blackColor.withOpacity(0.6),
                                        ),
                                        isMail: true,
                                        isVerified:
                                            authController.emailVerified.value),
                                  ),
                                ],
                              )
                            : SizedBox();
                      }),
                      const SizedBox(height: 14),
                      _settingsTile(context,
                          title: 'Privacy Policy',
                          leading: Icon(
                            Icons.policy_outlined,
                            size: 24,
                            color: blackColor.withOpacity(0.6),
                          )),
                      const SizedBox(height: 14),
                      _settingsTile(context,
                          title: 'Term & Conditions',
                          leading: Icon(
                            Icons.comment_bank_outlined,
                            size: 24,
                            color: blackColor.withOpacity(0.6),
                          )),
                      const SizedBox(height: 10),
                      _settingsTile(context,
                          title: 'Help',
                          leading: Icon(
                            Icons.help_outline,
                            size: 24,
                            color: blackColor.withOpacity(0.6),
                          )),
                      const SizedBox(height: 10),
                      _settingsTile(context,
                          title: 'Contact Us',
                          leading: Icon(
                            Icons.contact_mail_outlined,
                            size: 24,
                            color: blackColor.withOpacity(0.6),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    authController.logOutProfile().then((onValue) async {
                      if (onValue != "") {
                        // await Global.storageServices.removeAllData();
                        // await Global.apiClient.updateHeader(
                        //     Global.storageServices.getString("x-user-token"));
                        handleLogout(context);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: greyColor.withOpacity(0.15),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: redColor,
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            color: redColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,
                            size: 14, color: redColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Obx(() {
                return (authController.isLogoutProfileLoading.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox();
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _settingsTile(
    BuildContext context, {
    required String title,
    required Widget leading,
    bool isMail = false,
    bool isVerified = false,
  }) {
    return Row(
      children: [
        leading,
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        !isMail
            ? const Icon(Icons.arrow_forward_ios, size: 14)
            : isVerified
                ? const Text(
                    "verified",
                    style: TextStyle(
                        color: appColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  )
                : Obx(() {
                    return authController.isEmailLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : InkWell(
                            onTap: () async {
                              await authController
                                  .emailVerifyOtp(title)
                                  .then((onValue) async {
                                if (onValue != "") {
                                  final result = await showDialog(
                                    context: context,
                                    builder: (_) => OtpInputDialog(),
                                  );
                                  if (result != null && result != "") {
                                    await authController
                                        .verifyEmailOtp(result)
                                        .then((onValue) {
                                      if (onValue != "") {
                                        Get.snackbar(
                                            "wow", "email verify successfully");
                                      }
                                    });
                                  }
                                }
                              });
                            },
                            child: const Text(
                              " No verify",
                              style: TextStyle(
                                  color: redColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                  }),
      ],
    );
  }

  PersistCookieJar cookieJar = PersistCookieJar();
  Future<void> handleLogout(BuildContext context) async {
    final dir = await getApplicationDocumentsDirectory();
    cookieJar = PersistCookieJar(
      storage: FileStorage("${dir.path}/.cookies"),
    );

    // Navigate to LoginScreen
    Get.offAll(() => const MainLogin());
  }
}

class OtpInputDialog extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  final AuthController authController = Get.find();

  OtpInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: whiteColor,
      surfaceTintColor: whiteColor,
      title: const Text(
        'Enter OTP',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      content: TextField(
        controller: otpController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Enter the OTP sent on email',
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: greyColor),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final otp = otpController.text.trim();
            if (otp.isNotEmpty) {
              Navigator.of(context).pop(otp); // return result
            }
          },
          child: const Text(
            'Verify',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: appColor),
          ),
        ),
      ],
    );
  }
}
