import 'package:flutter/material.dart';
import 'package:smart_training/core/constant/Appsize.dart';
import 'package:smart_training/core/constant/appcolor.dart';

class CustomIconNotification extends StatelessWidget {
  const CustomIconNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(
            Icons.notifications_active_outlined,
          ),
          Positioned(
            right: -1.0,
            top: -6.0,
            child: Container(
              padding: const EdgeInsets.all(1.5),
              alignment: Alignment.center,
              width: AppSize.iconSize10 * 2.7,
              height: AppSize.iconSize10 * 2.78,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(AppSize.iconSize10 * 2),
              ),
              child: Text(
                "10",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: AppSize.iconSize10 * 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
