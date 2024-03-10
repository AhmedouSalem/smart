import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/core/constant/appcolor.dart';

Future<bool> appAlertExit() {
  Get.defaultDialog(
    title: 'Warning'.tr,
    content: Text("willExit".tr),
    textConfirm: "Confirm".tr,
    confirmTextColor: AppColor.linkColor,
    textCancel: "Cancel".tr,
    buttonColor: AppColor.primaryColor,
    cancelTextColor: AppColor.primaryColor,
    onConfirm: () {
      exit(0);
    },
    onCancel: () {
      Get.back();
    },
  );
  return Future.value(true);
}
