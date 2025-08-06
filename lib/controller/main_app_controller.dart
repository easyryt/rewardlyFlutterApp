import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_review/constant/constant_api_points.dart';
import 'package:job_review/model/get_all_apps_model.dart';
import 'package:job_review/model/get_single_apps_model.dart';
import 'package:job_review/services/global.dart';

class MainApplicationController extends GetxController {
  var isAppsLoading = false.obs;
  var isSingleAppsLoading = false.obs;

  Rx<GetAllAppsModel?> getAllAppsModel = Rx<GetAllAppsModel?>(null);
  var allAppsList = <AllAppsCampaigns>[].obs;
  Rx<GetSingleAppsModel?> getSingleAppsModel = Rx<GetSingleAppsModel?>(null);
  var singleAppsList = <FileterdCamp>[].obs;

  Future getAllApps() async {
    isAppsLoading.value = true;
    Dio.Response response =
        await Global.apiClient.getData(ConstantApiEndPoints.getAllApps);
    isAppsLoading.value = false;
    if (response.statusCode == 200) {
      final allApps = response.data;
      final appsM = GetAllAppsModel.fromJson(allApps);
      getAllAppsModel.value = appsM;
      if (getAllAppsModel.value != null) {
        allAppsList.value = appsM.campaigns!;
      }
      return allApps;
    } else {
      return false;
    }
  }

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
