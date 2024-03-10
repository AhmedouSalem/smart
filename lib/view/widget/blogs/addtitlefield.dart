import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTitleField extends StatelessWidget {
  const AddTitleField({super.key, required this.textEditingController});
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        isDense: true,
        hintText: "Title",
        hintStyle: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
              color: const Color.fromRGBO(0, 0, 0, 0.5),
            ),
        border: InputBorder.none,
      ),
    );
  }
}
