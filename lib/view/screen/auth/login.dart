import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/controller/auth/login_controller.dart';
import 'package:smart_training/core/constant/Appsize.dart';
import 'package:smart_training/core/constant/appcolor.dart';
import 'package:smart_training/core/constant/appimageassets.dart';
import 'package:smart_training/view/widget/auth/customtextform.dart';
import 'package:smart_training/view/widget/primarybutton.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.scaffoldColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          clipBehavior: Clip.none,
          // reverse: true,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppImageAssets.logoApp,
                  width: AppSize.fullWidth * 0.35,
                  height: AppSize.fullWidth * 0.35,
                ),
                SizedBox(height: AppSize.fullHeight * 0.045),
                CustomTextFormField(
                  textEditingController: loginController.email,
                  hintText: "Email",
                ),
                GetBuilder<LoginController>(
                  builder: (controller) => CustomTextFormField(
                    isPassword: controller.isHidden ? true : null,
                    textEditingController: controller.password,
                    hintText: "Password",
                    iconData: controller.iconData,
                    onPressed: () {
                      controller.showPassword();
                    },
                  ),
                ),
                SizedBox(height: AppSize.fullHeight * 0.045),
                GetBuilder<LoginController>(
                  builder: (controller) => PrimaryButton(
                    textBtn: "Se connecter",
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            controller.login();
                          },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
