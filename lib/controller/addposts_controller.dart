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
  late Rx<TextEditingController> title;
  late Rx<TextEditingController> description;
  RxBool isLoading = false.obs;
  PostsData postsData = PostsData(Get.find<Crud>());
  AppServices appServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  /// Add image
  File? file;
  String? imageUrl;
  Reference? ref;
  @override
  void onInit() {
    title = TextEditingController().obs;
    description = TextEditingController().obs;
    super.onInit();
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
      var rand = Random().nextInt(1000000);
      String nameImage = "$rand${basename(pickedImage.path)}";
      ref = FirebaseStorage.instance.ref("images").child(nameImage);
      Get.back();
    }
  }

  addPosts() async {
    if (file == null) {
      isLoading.value = true;
      var posts = await postsData.addPosts(
        FirebaseAuth.instance.currentUser!.uid,
        title.value.text.trim(),
        description.value.text.trim(),
        "",
      );
      statusRequest = await handlingData(posts);
      print(statusRequest);
      if (StatusRequest.success == statusRequest) {
        Get.offAllNamed(AppRoute.posts);
      } else {
        isLoading.value = false;
        rawSnackBar("Operation failed");
      }
    } else {
      isLoading.value = true;
      await ref?.putFile(file!);
      imageUrl = await ref!.getDownloadURL();
      if (imageUrl != null) {
        var posts = await postsData.addPosts(
          FirebaseAuth.instance.currentUser!.uid,
          title.value.text.trim(),
          description.value.text.trim(),
          imageUrl!,
        );
        statusRequest = await handlingData(posts);
        print(statusRequest);
        if (StatusRequest.success == statusRequest) {
          Get.offAllNamed(AppRoute.posts);
        } else {
          await FirebaseStorage.instance.refFromURL(imageUrl!).delete();
          isLoading.value = false;
          rawSnackBar("Failed send data to firestore");
        }
      } else {
        isLoading.value = false;
        rawSnackBar("Failed send data to cloud storage");
      }
    }
  }
}
