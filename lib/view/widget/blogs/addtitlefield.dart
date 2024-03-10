import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/controller/addposts_controller.dart';

class AddTitleField extends StatelessWidget {
  const AddTitleField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostsController>(
      builder: (controller) => TextFormField(
        onChanged: (value) {
          controller.onChangeTitle(value);
        },
        decoration: InputDecoration(
          isDense: true,
          hintText: "Title",
          hintStyle: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
