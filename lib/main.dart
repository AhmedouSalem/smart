import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_training/core/bindings/mybindings.dart';
import 'package:smart_training/core/constant/appcolor.dart';
import 'package:smart_training/core/services/appservices.dart';
import 'package:smart_training/routes.dart';

void main() async {
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: AppColor.primaryColor,
            iconTheme: IconThemeData(
              color: AppColor.whiteColor,
            ),
            titleTextStyle: TextStyle(color: AppColor.whiteColor),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: AppColor.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          )),
      title: 'Flutter App Blogs',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      initialRoute: "/",
      getPages: getPages,
      // home: ProfileImageScreen(),
    );
  }
}
