import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  const CustomTitleText({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(height: 0.0, color: Colors.black),
    );
  }
}
