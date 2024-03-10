import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/core/constant/approutes.dart';

abstract class AuthenticationController extends GetxController {
  bool isHidden = true;
  bool isLoading = false;
  IconData iconData = Icons.visibility_outlined;
  goToSignUp() {
    Get.offAllNamed(AppRoute.signUp);
  }

  goToLogin() {
    Get.offAllNamed(AppRoute.login);
  }

  showPassword() {
    isHidden = !isHidden;
    if (!isHidden) {
      iconData = Icons.visibility_off_outlined;
    } else {
      iconData = Icons.visibility_outlined;
    }
    update();
  }

  late TextEditingController email;
  late TextEditingController password;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
