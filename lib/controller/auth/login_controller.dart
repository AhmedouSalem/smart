import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/controller/auth/authentication_controller.dart';
import 'package:smart_training/core/class/crud.dart';
import 'package:smart_training/core/class/statusrequest.dart';
import 'package:smart_training/core/constant/approutes.dart';
import 'package:smart_training/core/functions/handlingdata.dart';
import 'package:smart_training/core/functions/rawsnackbar.dart';
import 'package:smart_training/core/services/appservices.dart';
import 'package:smart_training/data/datasource/remote/users_data.dart';

class LoginController extends AuthenticationController {
  StatusRequest statusRequest = StatusRequest.none;
  AppServices appServices = Get.find();
  UsersData usersData = UsersData(Get.find<Crud>());
  @override
  void onInit() {
    appServices.sharedPreferences.setString("step", "1");
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
      rawSnackBar("Please complete all fields");
    } else {
      isLoading = true;
      update();
      try {
        final UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());
        if (credential.user != null) {
          isLoading = false;
          appServices.sharedPreferences.setString("step", "2");
          var response = await usersData.getUsers(
            "users",
            FirebaseAuth.instance.currentUser!.uid,
          );
          statusRequest = await handlingData(response);
          print(statusRequest);
          if (StatusRequest.success == statusRequest) {
            Map<String, dynamic> data = response;
            await appServices.sharedPreferences
                .setString("users_name", "${data["users_name"]}");
            print("****$data");
          }
          Get.offAllNamed(AppRoute.posts);
        }
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        update();
        if (e.code == 'user-not-found') {
          rawSnackBar('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          rawSnackBar('Wrong password provided for that user.');
        }
      }
    }
  }
}
