import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:intl/intl.dart';
import 'package:job_review/constant/constant_api_points.dart';
import 'package:job_review/model/get_all_apps_model.dart';
import 'package:job_review/model/get_analytics_model.dart';
import 'package:job_review/model/get_single_apps_model.dart';
import 'package:job_review/model/get_submit_history_model.dart';
import 'package:job_review/model/get_submit_single_history_model.dart';
import 'package:job_review/screens/auth/profile_screen.dart';
import 'package:job_review/services/global.dart';

class MainApplicationController extends GetxController {
  var isAppsLoading = false.obs;
  var isSingleAppsLoading = false.obs;
  var isProofLoading = false.obs;
  var isSubmittedAppsLoading = false.obs;
  var isSubmittedSingleLoading = false.obs;
  var isAnalyticsLoading = false.obs;
  var refWallet = "0".obs;
  var installAmount = 0.obs;
  var reviewAmount = 0.obs;
  // var bannerList = [].obs;
  var bannerList = <Map<String, String>>[].obs;
  var currentIndex = 0.obs;
  var installedStatus = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();

    bannerList.addAll([
      {"url": "https://picsum.photos/id/1015/800/400"},
      {"url": "https://picsum.photos/id/1016/800/400"},
      {"url": "https://picsum.photos/id/1018/800/400"},
    ]);
  }

  Rx<GetAllAppsModel?> getAllAppsModel = Rx<GetAllAppsModel?>(null);
  var allAppsList = <AllAppsCampaigns>[].obs;
  Rx<GetSingleAppsModel?> getSingleAppsModel = Rx<GetSingleAppsModel?>(null);
  var singleAppsList = <FileterdCamp>[].obs;
  Rx<GetSubmitHistoryModel?> getSubmitHistoryModel =
      Rx<GetSubmitHistoryModel?>(null);
  var allSubmittedAppsList = <SubmitHistoryData>[].obs;
  Rx<GetSubmitSingleHistoryModel?> getSubmitSingleHistoryModel =
      Rx<GetSubmitSingleHistoryModel?>(null);
  var allSubmittedSingleList = <SubmitSingleHistoryData>[].obs;

  Rx<GetAnalyticsModel?> getAnalyticsModel = Rx<GetAnalyticsModel?>(null);

  // Future<void> checkInstalledApps() async {
  //   for (var app in allAppsList) {
  //     if (app.packageName != null && app.packageName!.isNotEmpty) {
  //       bool? isInstalled =
  //           await InstalledApps.isAppInstalled(app.packageName!);
  //       if (isInstalled != null) {
  //         installedStatus[app.packageName!] = isInstalled;
  //       }
  //     }
  //   }
  // }

  String? extractPackageName(String url) {
    Uri uri = Uri.tryParse(url) ?? Uri();
    return uri.queryParameters['id'];
  }

  Future<void> checkInstalledApps() async {
    for (var app in allAppsList) {
      String? pkg = app.packageName;
      if (pkg != null && pkg.isNotEmpty) {
        bool? isInstalled = await InstalledApps.isAppInstalled(pkg);
        if (isInstalled != null) {
          installedStatus[pkg] = isInstalled;
        }
      }
    }
  }

  Future getAllApps() async {
    isAppsLoading.value = true;
    Dio.Response response =
        await Global.apiClient.getData(ConstantApiEndPoints.getAllApps);
    isAppsLoading.value = false;

    if (response.statusCode == 200) {
      final allApps = response.data;
      final appsM = GetAllAppsModel.fromJson(allApps);
      getAllAppsModel.value = appsM;

      if (getAllAppsModel.value != null && appsM.campaigns != null) {
        allAppsList.value = appsM.campaigns!.map((app) {
          if (app.packageName != null && app.packageName!.startsWith("http")) {
            String? pkg = extractPackageName(app.packageName!);
            return app.copyWith(packageName: pkg);
          }
          return app;
        }).toList();
      }

      await checkInstalledApps();

      return allApps;
    } else {
      final responseData = response.data;
      Get.snackbar("alert", "${responseData['message']}");
      return false;
    }
  }
  // Future getAllApps() async {
  //   isAppsLoading.value = true;
  //   Dio.Response response =
  //       await Global.apiClient.getData(ConstantApiEndPoints.getAllApps);
  //   isAppsLoading.value = false;
  //   if (response.statusCode == 200) {
  //     final allApps = response.data;
  //     final appsM = GetAllAppsModel.fromJson(allApps);
  //     getAllAppsModel.value = appsM;
  //     if (getAllAppsModel.value != null && appsM.campaigns != null) {
  //       allAppsList.value = appsM.campaigns!;
  //     }
  //     return allApps;
  //   } else {
  //     final responseData = response.data;
  //
  //     Get.snackbar("alert", "${responseData['message']}");
  //     return false;
  //   }
  // }

  Future getSingleApps(appId) async {
    isSingleAppsLoading.value = true;
    Dio.Response response = await Global.apiClient
        .getData("${ConstantApiEndPoints.getSingleApps}/$appId");
    isSingleAppsLoading.value = false;
    if (response.statusCode == 200) {
      final allApp = response.data;
      final appM = GetSingleAppsModel.fromJson(allApp);
      getSingleAppsModel.value = appM;
      if (getSingleAppsModel.value != null) {
        singleAppsList.value = [appM.fileterdCamp!];
      }
      return allApp;
    } else {
      final responseData = response.data;

      if (responseData is Map<String, dynamic> &&
          responseData['status'] == false &&
          responseData['message'] == 'Complete your profile first') {
        Get.to(() => const ProfileScreen());
      }
      Get.snackbar("alert", "${responseData['message']}");
      return false;
    }
  }

  Future proofSubmit(appId, File imageFile) async {
    try {
      isProofLoading.value = true;

      String fileName = imageFile.path.split('/').last;

      Dio.FormData formData = Dio.FormData.fromMap({
        'proofUrl': await Dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });

      Dio.Response response = await Global.apiClient.postData(
        "${ConstantApiEndPoints.proofSubmit}/$appId",
        formData,
        null,
        // isFormData:
        //     true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getAllApps();
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
      isProofLoading.value = false;
    }
  }

  Future getSubmittedAllApps() async {
    isSubmittedAppsLoading.value = true;
    Dio.Response response =
        await Global.apiClient.getData(ConstantApiEndPoints.getSubmittedApps);
    isSubmittedAppsLoading.value = false;
    if (response.statusCode == 200) {
      final allApps = response.data;
      final appsM = GetSubmitHistoryModel.fromJson(allApps);
      getSubmitHistoryModel.value = appsM;
      if (getSubmitHistoryModel.value != null) {
        allSubmittedAppsList.value = appsM.data!;
      }
      return allApps;
    } else {
      final responseData = response.data;

      Get.snackbar("alert", "${responseData['message']}");
      return false;
    }
  }

  Future getSubmittedSingleApps(appId) async {
    isSubmittedSingleLoading.value = true;
    Dio.Response response = await Global.apiClient
        .getData("${ConstantApiEndPoints.getSubmittedApps}/$appId");
    isSubmittedSingleLoading.value = false;
    if (response.statusCode == 200) {
      final allApps = response.data;
      final appsM = GetSubmitSingleHistoryModel.fromJson(allApps);
      getSubmitSingleHistoryModel.value = appsM;
      if (getSubmitSingleHistoryModel.value != null) {
        allSubmittedSingleList.value = [appsM.data!];
      }
      return allApps;
    } else {
      final responseData = response.data;

      Get.snackbar("alert", "${responseData['message']}");
      return false;
    }
  }

  Future getAllAnalytics() async {
    isAnalyticsLoading.value = true;
    Dio.Response response =
        await Global.apiClient.getData(ConstantApiEndPoints.getAllAnalytics);
    isAnalyticsLoading.value = false;
    if (response.statusCode == 200) {
      final allAnalytic = response.data;
      final analyticM = GetAnalyticsModel.fromJson(allAnalytic);
      if (analyticM.earnings?.referralWallet != 0) {
        refWallet.value = "${analyticM.earnings?.referralWallet}";
      }
      getAnalyticsModel.value = analyticM;
      // if (getAnalyticsModel.value != null) {
      //   allSubmittedAppsList.value = analyticM.data!;
      // }
      return allAnalytic;
    } else {
      final responseData = response.data;

      Get.snackbar("alert", "${responseData['message']}");
      return false;
    }
  }

  Future getRewardAmount() async {
    Dio.Response response =
        await Global.apiClient.getData(ConstantApiEndPoints.getRewardAmount);
    if (response.statusCode == 200) {
      final allRewardAmount = response.data;
      reviewAmount.value = allRewardAmount["data"]["reviewAmount"];
      installAmount.value = allRewardAmount["data"]["installAmount"];
      return allRewardAmount;
    } else {
      final responseData = response.data;

      Get.snackbar("alert", "${responseData['message']}");
      return false;
    }
  }

  //date format ................

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  String formatNextFollowDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd/MM/yyyy hh:mm aa').format(dateTime);
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
        return '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(date.toUtc())}Z';
      } catch (e) {}
    }

    return 'Invalid date format';
  }
}
