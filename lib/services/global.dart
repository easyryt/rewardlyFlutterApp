import 'package:flutter/cupertino.dart';
import 'package:job_review/services/api_client.dart';
import 'package:job_review/services/global_api_service.dart';
import 'package:job_review/services/storage_services.dart';

class Global {
  static late StorageServices storageServices;
  static late ApiClient apiClient;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    storageServices = await StorageServices().init();
    apiClient = ApiServices().init();
  }
}
