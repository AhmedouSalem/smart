import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDescriptionField extends StatelessWidget {
  const AddDescriptionField({super.key, required this.textEditingController});
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "Write something",
        hintStyle: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
              color: const Color.fromRGBO(0, 0, 0, 0.5),
            ),
      ),
    );
  }
}
