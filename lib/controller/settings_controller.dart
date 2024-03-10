import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_training/core/constant/approutes.dart';
import 'package:smart_training/core/services/appservices.dart';

class SettingsController extends GetxController {
  AppServices appServices = Get.find();
  late String username;

  @override
  void onInit() {
    username = appServices.sharedPreferences.getString("users_name")!;
    super.onInit();
  }

  exitToApp() async {
    await FirebaseAuth.instance.signOut();
    appServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login);
  }
}
