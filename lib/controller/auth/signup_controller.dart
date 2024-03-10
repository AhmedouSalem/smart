import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_training/controller/auth/authentication_controller.dart';

class SignUpController extends AuthenticationController {
  late TextEditingController username;
  bool checked = false;
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  onChecked() {
    checked = !checked;
    update();
  }

  signUp() async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      if (credential.user != null) {
        await users
            .doc(credential.user!.uid)
            .set({
              // "users_id": credential.user!.uid,
              "users_name": username.text.trim(),
            })
            .then((value) => Get.rawSnackbar(message: "User Added"))
            .catchError((error) =>
                Get.rawSnackbar(message: "Failed to add user: $error"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.rawSnackbar(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.rawSnackbar(message: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
