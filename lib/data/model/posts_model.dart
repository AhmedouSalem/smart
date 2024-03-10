import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  String? postID;
  String? usersName;
  String? postsUsers;
  String? postsTitle;
  String? postsText;
  String? postsImage;
  Timestamp? postsDate;

  PostsModel({
    this.postID,
    this.usersName,
    this.postsUsers,
    this.postsTitle,
    this.postsText,
    this.postsImage,
    this.postsDate,
  });

  PostsModel.fromJson(Map<String, dynamic> json) {
    postID = json['posts_ID'];
    usersName = json['users_name'];
    postsUsers = json['posts_users'];
    postsTitle = json['posts_title'];
    postsText = json['posts_text'];
    postsImage = json['posts_image'];
    postsDate = json['posts_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['posts_ID'] = postID;
    data['users_name'] = usersName;
    data['posts_users'] = postsUsers;
    data['posts_title'] = postsTitle;
    data['posts_text'] = postsText;
    data['posts_image'] = postsImage;
    data['posts_date'] = postsDate;
    return data;
  }
}
