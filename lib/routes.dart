import 'package:get/get.dart';
import 'package:smart_training/core/constant/approutes.dart';
import 'package:smart_training/core/services/appmiddleware.dart';
import 'package:smart_training/view/screen/auth/login.dart';
import 'package:smart_training/view/screen/auth/signup.dart';
import 'package:smart_training/view/screen/blogs/addposts.dart';
import 'package:smart_training/view/screen/blogs/posts.dart';
import 'package:smart_training/view/screen/blogs/posts_details.dart';
import 'package:smart_training/view/screen/settings.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: AppRoute.login,
    page: () => const Login(),
    middlewares: [
      AppMiddleWare(),
    ],
  ),
  GetPage(
    name: AppRoute.signUp,
    page: () => const SignUp(),
  ),
  GetPage(
    name: AppRoute.posts,
    page: () => const PostsView(),
  ),
  GetPage(
    name: AppRoute.postsDetails,
    page: () => const PostsDetails(),
  ),
  GetPage(
    name: AppRoute.settings,
    page: () => const PostsSettings(),
  ),
  GetPage(
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 800),
    name: AppRoute.addPosts,
    page: () => const AddPosts(),
  ),
];
