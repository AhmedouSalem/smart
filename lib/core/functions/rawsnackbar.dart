import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/core/constant/appcolor.dart';

void rawSnackBar(String text) {
  Get.rawSnackbar(
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColor.whiteColor,
    messageText: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
