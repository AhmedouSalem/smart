import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/controller/addposts_controller.dart';
import 'package:smart_training/core/constant/appcolor.dart';
import 'package:smart_training/core/constant/appimageassets.dart';
import 'package:smart_training/view/widget/blogs/adddescriptionfield.dart';
import 'package:smart_training/view/widget/blogs/addtitlefield.dart';
import 'package:smart_training/view/widget/blogs/chooseimage.dart';

class AddPosts extends StatelessWidget {
  const AddPosts({super.key});

  @override
  Widget build(BuildContext context) {
    AddPostsController addPostsController = Get.put(AddPostsController());
    return Scaffold(
      bottomSheet: Container(
        color: AppColor.whiteColor,
        child: ListTile(
          leading: const Icon(Icons.photo_album_rounded),
          title: const Text("Gallery / Camera"),
          onTap: () {
            addPostsController.shooseImage(
              const ShooseImage(),
            );
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 246, 206, 206),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
        ),
        centerTitle: true,
        title: Text(
          "Add blogs",
          style: Theme.of(Get.context!).textTheme.titleLarge!,
        ),
        actions: [
          GetX<AddPostsController>(
            builder: (controller) => controller.isLoading.value
                ? const CircularProgressIndicator()
                : IconButton(
                    onPressed: controller.title.value.text.trim().isEmpty ||
                            controller.description.value.text.trim().isEmpty
                        ? null
                        : () {
                            controller.addPosts();
                          },
                    icon: const Icon(Icons.send),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            GetX<AddPostsController>(
              builder: (controller) => Column(
                children: [
                  AddTitleField(
                    textEditingController: controller.title.value,
                  ),
                  const Divider(thickness: 2.0, color: Colors.grey),
                  SingleChildScrollView(
                    child: AddDescriptionField(
                      textEditingController: controller.description.value,
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<AddPostsController>(
              builder: (controller) => controller.file == null
                  ? Image.asset(
                      AppImageAssets.myImage,
                      width: double.infinity,
                    )
                  : Image.file(controller.file!),
            ),
          ],
        ),
      ),
    );
  }
}
