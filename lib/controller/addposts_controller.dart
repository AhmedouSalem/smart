import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_training/core/class/crud.dart';
import 'package:smart_training/core/class/statusrequest.dart';
import 'package:smart_training/core/constant/appcolor.dart';
import 'package:smart_training/core/constant/approutes.dart';
import 'package:smart_training/core/functions/handlingdata.dart';
import 'package:smart_training/core/functions/rawsnackbar.dart';
import 'package:smart_training/core/services/appservices.dart';
import 'package:smart_training/data/datasource/remote/posts_data.dart';

class AddPostsController extends GetxController {
  String title = "";
  String description = "";
  bool isLoading = false;
  PostsData postsData = PostsData(Get.find<Crud>());
  AppServices appServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  /// Add image
  File? file;
  String? imageUrl;
  Reference? ref;

  onChangeTitle(String value) {
    title = value.trim();
    update();
  }

  onChangeDescription(String value) {
    description = value.trim();
    update();
  }

  shooseImage(Widget widget) async {
    Get.bottomSheet(widget, backgroundColor: AppColor.whiteColor);
  }

  openGallery() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      update();
      var rand = Random().nextInt(1000000);
      String nameImage = "$rand${basename(pickedImage.path)}";
      ref = FirebaseStorage.instance.ref("images").child(nameImage);
      Get.back();
    }
  }

  openCamera() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      update();
      var rand = Random().nextInt(1000000);
      String nameImage = "$rand${basename(pickedImage.path)}";
      ref = FirebaseStorage.instance.ref("images").child(nameImage);
      Get.back();
    }
  }

  addPosts() async {
    if (file == null) {
      isLoading = true;
      update();
      var posts = await postsData.addPosts(
        FirebaseAuth.instance.currentUser!.uid,
        title.trim(),
        description.trim(),
        "",
      );
      statusRequest = await handlingData(posts);
      print(statusRequest);
      if (StatusRequest.success == statusRequest) {
        Get.offAllNamed(AppRoute.posts);
      } else {
        isLoading = false;
        update();
        rawSnackBar("Operation failed");
      }
    } else {
      isLoading = true;
      update();
      await ref?.putFile(file!);
      imageUrl = await ref!.getDownloadURL();
      if (imageUrl != null) {
        var posts = await postsData.addPosts(
          FirebaseAuth.instance.currentUser!.uid,
          title.trim(),
          description.trim(),
          imageUrl!,
        );
        statusRequest = await handlingData(posts);
        print(statusRequest);
        if (StatusRequest.success == statusRequest) {
          Get.offAllNamed(AppRoute.posts);
        } else {
          await FirebaseStorage.instance.refFromURL(imageUrl!).delete();
          isLoading = false;
          update();
          rawSnackBar("Failed send data to firestore");
        }
      } else {
        isLoading = false;
        update();
        rawSnackBar("Failed send data to cloud storage");
      }
    }
  }
}
