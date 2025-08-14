import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_review/constant/constant_api_points.dart';
import 'package:job_review/model/employee_auth_profile_model.dart';
import 'package:job_review/screens/auth/sign_up_screen.dart';
import 'package:job_review/services/global.dart';

class AuthController extends GetxController {
  var isLoginLoading = false.obs;
  var isGetProfileLoading = false.obs;
  var isUpdateProfileLoading = false.obs;
  var isLogoutProfileLoading = false.obs;
  var isEmailLoading = false.obs;
  var nameUser = "User Name".obs;
  var refCode = "".obs;
  var wallet = "0".obs;
  var emailUser = "".obs;
  var emailVerified = false.obs;
  Rx<EmployeeAuthProfileModel?> employeeAuthProfileModel =
      Rx<EmployeeAuthProfileModel?>(null);
  var empProfileList = <EmployeeAuthProfileData>[].obs;

  Future signup(String mobile) async {
    try {
      isLoginLoading.value = true;
      Dio.Response response = await Global.apiClient.postData(
        ConstantApiEndPoints.signUpEndPoint,
        {
          'phone': mobile,
        },
        null,
      );
      isLoginLoading.value = false;
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.data;
        String otp = data['otp'];
        print("$otp ............................................");
        return otp;
      } else {
        final responseData = response.data;

        Get.snackbar("alert", "${responseData['message']}");
        return false;
      }
    } catch (e) {
      Get.snackbar('alert', e.toString());
      return false;
    } finally {
      isLoginLoading.value = false;
    }
  }

  Future login(String name, String email, String mobile, String gender,
      String fcm, String? refer, String otp) async {
    try {
      isLoginLoading.value = true;
      Dio.Response response = await Global.apiClient.postData(
        ConstantApiEndPoints.loginEndPoint,
        {
          if (name != "") 'name': name,
          if (gender != "") 'gender': gender,
          if (email != "") 'email': email,
          if (mobile != "") 'phone': mobile,
          if (refer != null && refer != "") 'refCode': refer,
          if (otp != "") 'otp': otp,
          if (fcm != "") 'fcm': fcm,
        },
        null,
      );
      isLoginLoading.value = false;

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Logged in successfully');
        return response.data["data"];
      } else {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData['status'] == false &&
            responseData['message'] == 'Sign Up first') {
          Get.offAll(() => const SignUpScreen());
        }

        Get.snackbar("alert", "${responseData['message']}");
        return null;
      }
    } catch (e) {
      Get.snackbar("alert", "$e");
      return null;
    } finally {
      isLoginLoading.value = false;
    }
  }

  Future getEmpProfile() async {
    isGetProfileLoading.value = true;
    Dio.Response response =
        await Global.apiClient.getData(ConstantApiEndPoints.getEmpProfile);
    isGetProfileLoading.value = false;
    if (response.statusCode == 200) {
      final empProfile = response.data;
      final profileM = EmployeeAuthProfileModel.fromJson(empProfile);
      employeeAuthProfileModel.value = profileM;

      if (empProfile["data"]["name"] != null) {
        nameUser.value = empProfile["data"]["name"];
      }
      if (empProfile["data"]["refCode"] != null) {
        refCode.value = empProfile["data"]["refCode"];
      }
      if (empProfile["data"]["wallet"] != null) {
        wallet.value = "${empProfile["data"]["wallet"]}";
      }
      if (empProfile["data"]["email"] != null) {
        emailUser.value = empProfile["data"]["email"];
      }
      emailVerified.value = empProfile["data"]["isEmailVerified"];
      if (employeeAuthProfileModel.value != null) {
        empProfileList.value = [profileM.data!];
      }

      return empProfile;
    } else {
      final responseData = response.data;

      Get.snackbar("alert", "${responseData['message']}");
      return false;
    }
  }

  Future updateProfile(Map<String, dynamic> data) async {
    try {
      isUpdateProfileLoading.value = true;

      Dio.Response response = await Global.apiClient.putData(
        ConstantApiEndPoints.updateEmpProfile,
        data,
        null,
      );
      isUpdateProfileLoading.value = false;
      if (response.statusCode == 200) {
        await getEmpProfile();

        return response.data;
      } else {
        final responseData = response.data;

        Get.snackbar("alert", "${responseData['message']}");
        return "";
      }
    } catch (e) {
      Get.snackbar("alert", "$e");
      return "";
    } finally {
      isUpdateProfileLoading.value = false;
    }
  }

  Future logOutProfile() async {
    try {
      isLogoutProfileLoading.value = true;

      Dio.Response response = await Global.apiClient
          .postData(ConstantApiEndPoints.logOutProfile, {}, null);
      isLogoutProfileLoading.value = false;
      if (response.statusCode == 200) {
        return response.data;
      } else {
        final responseData = response.data;

        Get.snackbar("alert", "${responseData['message']}");
        return "";
      }
    } catch (e) {
      Get.snackbar("alert", "$e");
      return "";
    } finally {
      isLogoutProfileLoading.value = false;
    }
  }

  // Future emailVerifyOtp(email) async {
  //   try {
  //     isEmailLoading.value = true;
  //
  //     Dio.Response response = await Global.apiClient.postData(
  //         ConstantApiEndPoints.emailVerifyOtp, {"email": email}, null);
  //     isEmailLoading.value = false;
  //     if (response.statusCode == 200) {
  //       return response.data;
  //     } else {
  //       Get.snackbar("alert", "$response");
  //       return "";
  //     }
  //   } catch (e) {
  //     // if (kDebugMode) {
  //     //   print("otp email failed: $e");
  //     // }
  //     Get.snackbar("alert", "$e");
  //     return "";
  //   } finally {
  //     isEmailLoading.value = false;
  //   }
  // }

  // Future verifyEmailOtp(otp) async {
  //   try {
  //     isEmailLoading.value = true;
  //
  //     Dio.Response response = await Global.apiClient
  //         .postData(ConstantApiEndPoints.verifyEmailOtp, {"otp": otp}, null);
  //     isEmailLoading.value = false;
  //     if (response.statusCode == 200) {
  //       //  await cookieJar.deleteAll();
  //       await getEmpProfile();
  //       return response.data;
  //     } else {
  //       return "";
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("otp verify failed: $e");
  //     }
  //     return "";
  //   } finally {
  //     isEmailLoading.value = false;
  //   }
  // }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  String calculate(String date1, String date2) {
    DateTime dt1 = DateTime.parse(date1);
    DateTime dt2 = DateTime.parse(date2);

    int years = dt2.year - dt1.year;
    int months = dt2.month - dt1.month;
    int days = dt2.day - dt1.day;

    if (days < 0) {
      months--;
      days += DateTime(dt2.year, dt2.month, 0).day;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    List<String> parts = [];

    if (years > 0) parts.add('$years year${years > 1 ? 's' : ''}');
    if (months > 0) parts.add('$months month${months > 1 ? 's' : ''}');
    // if (days > 0) parts.add('$days day${days > 1 ? 's' : ''}');

    return parts.join(', ');
  }

  String formatSendDate(String dateStr) {
    List<String> dateFormats = [
      'dd-MM-yyyy',
      'MM-dd-yyyy',
      'yyyy-dd-MM',
      'yyyy-MM-dd',
      'MM,dd,yyyy',
      'dd,MM,yyyy',
      'yyyy,dd,MM',
      'yyyy,MM,dd',
    ];

    for (var format in dateFormats) {
      try {
        var date = DateFormat(format).parse(dateStr);
        return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(date.toUtc()) + 'Z';
      } catch (e) {}
    }

    return 'Invalid date format';
  }
}
