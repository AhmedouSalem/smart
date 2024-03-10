import 'package:flutter/material.dart';
import 'package:smart_training/core/constant/Appsize.dart';
import 'package:smart_training/core/constant/appcolor.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.textBtn, this.onPressed});
  final String textBtn;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.fullHeight * 0.060,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.fullWidth * 0.02),
        ),
        color: AppColor.primaryColor,
        disabledColor: const Color.fromRGBO(6, 122, 59, 0.5),
        textColor: AppColor.whiteColor,
        onPressed: onPressed,
        child: onPressed == null
            ? const CircularProgressIndicator(
                color: AppColor.whiteColor,
              )
            : Text(
                style: TextStyle(fontSize: AppSize.fullHeight * 0.022),
                textBtn,
              ),
      ),
    );
  }
}
