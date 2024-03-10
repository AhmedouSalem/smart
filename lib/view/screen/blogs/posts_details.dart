import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/controller/posts_details_controller.dart';
import 'package:smart_training/core/constant/Appsize.dart';
import 'package:smart_training/core/constant/appcolor.dart';
import 'package:smart_training/core/constant/appimageassets.dart';

class PostsDetails extends StatelessWidget {
  const PostsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    PostsDetailsController postsDetailsController =
        Get.put(PostsDetailsController());
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: AppColor.whiteColor,
                  child: Hero(
                    tag: "${postsDetailsController.postsModel.postID}",
                    child:
                        postsDetailsController.postsModel.postsImage!.isNotEmpty
                            ? Image.network(
                                "${postsDetailsController.postsModel.postsImage}",
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: AppSize.fullWidth / 1.2,
                              )
                            : Image.asset(
                                AppImageAssets.posts,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: AppSize.fullWidth / 1.2,
                              ),
                  ),
                ),
                Positioned(
                  top: -3,
                  left: -6,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                "${postsDetailsController.postsModel.postsTitle}",
                style: Theme.of(Get.context!)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              ),
            ),
            Text("${postsDetailsController.postsModel.postsText}"),
          ],
        ),
      ),
    );
  }
}
