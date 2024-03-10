import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_training/controller/posts_controller.dart';
import 'package:smart_training/core/constant/Appsize.dart';
import 'package:smart_training/core/constant/appcolor.dart';
import 'package:smart_training/core/constant/appimageassets.dart';
import 'package:smart_training/data/model/posts_model.dart';

class CustomCardBlogs extends GetView<PostsController> {
  const CustomCardBlogs({super.key, required this.postsModel});
  final PostsModel postsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(AppSize.fullWidth * 0.02)),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ListTile(
            onTap: () {
              controller.goToPostsDetails(postsModel);
            },
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 9.0, vertical: 0.0),
            leading: Container(
              width: AppSize.fullWidth * 0.15,
              height: AppSize.fullWidth * 0.15,
              color: AppColor.linkColor,
              child: Hero(
                tag: "${postsModel.postID}",
                child: postsModel.postsImage!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: "${postsModel.postsImage}",
                        placeholder: (context, url) => Lottie.asset(
                          AppImageAssets.loading,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        AppImageAssets.posts,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            title: Text(
              "${postsModel.postsTitle}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
            subtitle: Text("${postsModel.usersName}"),
          ),
          Positioned(
            top: -0.1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.4),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(AppSize.fullWidth * 0.02),
                  bottomLeft: Radius.circular(AppSize.fullWidth * 0.02),
                ),
              ),
              child: Text(
                controller.calculateDate(
                  postsModel.postsDate!.toDate(),
                ),
                style: const TextStyle(color: AppColor.whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
