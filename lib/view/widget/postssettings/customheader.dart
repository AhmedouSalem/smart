import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/core/constant/Appsize.dart';
import 'package:smart_training/core/constant/appcolor.dart';
import 'package:smart_training/core/constant/appimageassets.dart';

class CustomHeaderSettings extends StatelessWidget {
  const CustomHeaderSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: AppColor.primaryColor,
          width: double.infinity,
          height: AppSize.fullWidth * 0.5,
        ),
        const Icon(Icons.camera_alt_outlined),
        Positioned(
          bottom: -AppSize.fullWidth * 0.18,
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.fullWidth * 0.5),
                border: Border.all(width: 5.0, color: AppColor.whiteColor),
              ),
              child: ClipOval(
                child: Hero(
                  tag: "MyProfile",
                  child: Image.asset(
                    AppImageAssets.myImage,
                    width: AppSize.fullWidth * 0.4,
                    height: AppSize.fullWidth * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 1,
          left: 1,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ],
    );
  }
}
