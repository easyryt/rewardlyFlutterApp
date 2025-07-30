import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_review/constant/color_const.dart';
import 'package:job_review/controller/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  initFunction() async {
    await authController.getEmpProfile().then((onValue) {
      if (onValue != false) {
        if (onValue["data"]["name"] != null) {
          nameController.text = onValue["data"]["name"];
        }
        if (onValue["data"]["email"] != null) {
          emailController.text = onValue["data"]["email"];
        }
        if (onValue["data"]["phone"] != null) {
          phoneController.text = onValue["data"]["phone"];
        }
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    initFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: whiteColor,
        body: Obx(() {
          if (authController.isGetProfileLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (authController.empProfileList.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Data not available."),
                const SizedBox(height: 16),
                TextButton(
                    onPressed: () {
                      initFunction();
                    },
                    child: const Text(
                      "Retry",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ))
              ],
            ));
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: authController.empProfileList.length,
            itemBuilder: (context, index) {
              final profile = authController.empProfileList[index];
              return Stack(
                children: [
                  _buildLeadCard(profile, size),
                  Positioned(
                    top: 40,
                    right: 14,
                    child: InkWell(
                      onTap: () async {
                        var data = {
                          "name": nameController.text,
                          "email": emailController.text,
                        };
                        await authController
                            .updateProfile(data)
                            .then((onValue) {
                          if (onValue != "") {
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 8, bottom: 8, top: 8),
                        // margin: const EdgeInsets.only(
                        //     left: 8, right: 12, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Icon(
                            Icons.save,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 14,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 12, right: 6, bottom: 8, top: 8),
                        // margin: const EdgeInsets.only(
                        //     left: 8, right: 12, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (authController.isUpdateProfileLoading.value)
                    const Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            },
          );
        }));
  }

  Widget _buildLeadCard(profile, size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: const BoxDecoration(
            color: appColor,
            // image: DecorationImage(
            //     image: AssetImage("assets/images/profile_back.png"),
            //     fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              const SizedBox(height: 26),
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(36),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      spreadRadius: 0.65,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    profile.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                        fontSize: 40,
                        color: appColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                profile.name,
                style: GoogleFonts.poppins(
                  color: whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     if (profile.email != null)
              //       InkWell(
              //           onTap: () async {
              //             if (profile.email != null) {
              //               final emailN = profile.email!;
              //               final url = 'mailto:$emailN';
              //               // if (await canLaunch(url)) {
              //               await launch(url);
              //               // } else {
              //               //   throw 'Could not launch $url';
              //               // }}
              //             }
              //           },
              //           child: _iconButton(Icons.email, profile.email)),
              //     InkWell(
              //         onTap: () async {
              //           if (profile.phone != null) {
              //             final phoneNumber = profile.phone!;
              //             final url = 'tel:$phoneNumber';
              //             // if (await canLaunch(url)) {
              //             await launch(url);
              //             // } else {
              //             //   throw 'Could not launch $url';
              //             // }}
              //           }
              //         },
              //         child: _iconButton(Icons.phone, "${profile.phone}")),
              //   ],
              // ),
            ],
          ),
        ),
        // Bottom white card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: phoneController,
                  cursorColor: blackColor,
                  readOnly: true,
                  style: const TextStyle(color: blackColor),
                  decoration: InputDecoration(
                    labelText: "Phone No.",
                    labelStyle: GoogleFonts.roboto(color: blackColor),
                    floatingLabelStyle: GoogleFonts.roboto(color: blackColor),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: nameController,
                  cursorColor: blackColor,
                  style: const TextStyle(color: blackColor),
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: GoogleFonts.roboto(color: blackColor),
                    floatingLabelStyle: GoogleFonts.roboto(color: blackColor),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: emailController,
                  cursorColor: blackColor,
                  style: const TextStyle(color: blackColor),
                  decoration: InputDecoration(
                    labelText: "Email ID",
                    labelStyle: GoogleFonts.roboto(color: blackColor),
                    floatingLabelStyle: GoogleFonts.roboto(color: blackColor),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
