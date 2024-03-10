import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/controller/addposts_controller.dart';

class ShooseImage extends GetView<AddPostsController> {
  const ShooseImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      // height: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Please Choose Image",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () async {
              controller.openGallery();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Icon(Icons.photo_outlined, size: 30),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "From Gallery",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              controller.openCamera();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Icon(Icons.camera, size: 30),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "From Camera",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
