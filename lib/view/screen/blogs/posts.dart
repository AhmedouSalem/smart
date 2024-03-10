import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:smart_training/controller/posts_controller.dart';
import 'package:smart_training/core/class/handlingdataview.dart';
import 'package:smart_training/core/constant/Appsize.dart';
import 'package:smart_training/core/constant/appcolor.dart';
import 'package:smart_training/core/constant/appimageassets.dart';
import 'package:smart_training/view/widget/blogs/IconNotification.dart';
import 'package:smart_training/view/widget/blogs/customcard.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    PostsController postsController = Get.put(PostsController());
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
          postsController.goToAddPosts();
        },
        child: const Icon(
          Icons.add,
          color: AppColor.whiteColor,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Posts",
          style: Theme.of(Get.context!).textTheme.titleLarge!,
        ),
        iconTheme: IconThemeData(
          size: AppSize.iconSize10 * 4,
          color: AppColor.whiteColor,
        ),
        actions: [
          const CustomIconNotification(),
          IconButton(
            onPressed: () async {
              postsController.goToSettings();
            },
            icon: ClipOval(
              child: Hero(
                tag: "MyProfile",
                child: Image.asset(
                  AppImageAssets.myImage,
                  width: AppSize.iconSize10 * 4,
                  height: AppSize.iconSize10 * 4,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<PostsController>(
          builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              itemCount: controller.postsModel.length,
              itemBuilder: (context, index) =>
                  CustomCardBlogs(postsModel: controller.postsModel[index]),
            ),
          ),
        ),
      ),
    );
  }
}
