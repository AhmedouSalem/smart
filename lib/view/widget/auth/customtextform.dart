import 'package:flutter/material.dart';
import 'package:smart_training/core/constant/Appsize.dart';
import 'package:smart_training/core/constant/appcolor.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.iconData,
    this.onPressed,
    this.isPassword,
    required this.textEditingController,
  });
  final String hintText;
  final IconData? iconData;
  final void Function()? onPressed;
  final bool? isPassword;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.fullHeight * 0.07,
      margin: EdgeInsets.only(bottom: AppSize.fullHeight * 0.035),
      child: TextFormField(
        controller: textEditingController,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        obscureText: isPassword ?? false,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(
              iconData,
              size: AppSize.iconSize10 * 3,
            ),
          ),
          fillColor: AppColor.whiteColor,
          filled: true,
          hintText: hintText,
          isDense: true,
          hintMaxLines: 1,
          hintStyle: TextStyle(fontSize: AppSize.fontSize10 * 1.05),
          contentPadding: EdgeInsets.only(left: AppSize.fullWidth * 0.068),
          // enabled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.fullWidth * 0.02),
            borderSide: const BorderSide(color: AppColor.whiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.fullWidth * 0.02),
            borderSide: const BorderSide(color: AppColor.whiteColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.fullWidth * 0.02),
            borderSide: const BorderSide(color: AppColor.whiteColor),
          ),
        ),
      ),
    );
  }
}
