import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/controller/addposts_controller.dart';

class AddDescriptionField extends StatelessWidget {
  const AddDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostsController>(
      builder: (controller) => TextFormField(
        onChanged: (value) {
          controller.onChangeDescription(value);
        },
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Write something",
          hintStyle: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
        ),
      ),
    );
  }
}
