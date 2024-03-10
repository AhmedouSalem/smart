import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/core/constant/approutes.dart';
import 'package:smart_training/core/services/appservices.dart';

class AppMiddleWare extends GetMiddleware {
  AppServices appServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    if (appServices.sharedPreferences.getString("step") == "2") {
      return const RouteSettings(name: AppRoute.posts);
    }
    return super.redirect(route);
  }
}
