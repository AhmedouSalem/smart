import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_training/core/class/crud.dart';
import 'package:smart_training/core/class/statusrequest.dart';

class PostsData {
  Crud crud;
  PostsData(
    this.crud,
  );

  getPosts() async {
    Either<StatusRequest, List<Map<String, dynamic>>> response =
        await crud.getPostsAndUsers();
    return response.fold((l) => l, (r) => r);
  }

  addPosts(String usersID, String title, String desc, String imageUrl) async {
    Either<StatusRequest, DocumentReference<Map<String, dynamic>>> response =
        await crud.addData("posts", {
      "posts_users": usersID,
      "posts_title": title,
      "posts_text": desc,
      "posts_image": imageUrl,
      "posts_date": Timestamp.now(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
