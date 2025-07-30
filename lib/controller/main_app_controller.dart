import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainApplicationController extends GetxController {
  var isBulkLeadUploading = false.obs;

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
