import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back;
          },
          icon: const Icon(Icons.close),
        ),
        centerTitle: true,
        title: Text(
          "Add blogs",
          style: Theme.of(Get.context!).textTheme.titleLarge!,
        ),
        actions: [
          GetBuilder<AddPostsController>(
            builder: (controller) => controller.isLoading
                ? const CircularProgressIndicator()
                : IconButton(
                    onPressed: controller.title.trim().isEmpty ||
                            controller.description.trim().isEmpty
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
            const AddTitleField(),
            const Divider(thickness: 2.0, color: Colors.grey),
            const SingleChildScrollView(
              child: AddDescriptionField(),
            ),
            GetBuilder<AddPostsController>(
              builder: (controller) => controller.file == null
                  ? Image.asset(
                      AppImageAssets.gallery,
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
