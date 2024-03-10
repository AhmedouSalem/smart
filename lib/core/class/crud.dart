import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smart_training/core/class/statusrequest.dart';
import 'package:smart_training/core/functions/checkinternet.dart';

class Crud {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Ajouter des données
  Future<Either<StatusRequest, DocumentReference<Map<String, dynamic>>>>
      addData(String collection, Map<String, dynamic> data) async {
    try {
      if (await checkInternet()) {
        DocumentReference<Map<String, dynamic>> addingData =
            await _firebaseFirestore.collection(collection).add(data);
        return Right(addingData);
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  // Ajouter des données avec une image
  Future<Either<StatusRequest, Map<String, dynamic>>> addDataWithImage(
      String collection, Map<String, dynamic> data, File? image) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await _firebaseFirestore.collection(collection).add(data);

      if (image != null) {
        String imagePath = 'images/${documentReference.id}.jpg';
        await _uploadImage(image, imagePath);
        String imageUrl = await _getImageUrl(imagePath);
        Map<String, dynamic> updatedData = {'image_url': imageUrl};
        await documentReference.update(updatedData);
        return Right({...data, ...updatedData});
      }

      return Right(data);
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, List<Map<String, dynamic>>>>
      getPostsAndUsers() async {
    try {
      if (await checkInternet()) {
        List<Map<String, dynamic>> data = [];
        // Récupérer les documents de la collection "users"
        var usersSnapshot =
            await FirebaseFirestore.instance.collection("users").get();

        // Créer une Map pour stocker les données des utilisateurs avec leur ID
        Map<String, Map<String, dynamic>> usersData = {};

        for (var userDocument in usersSnapshot.docs) {
          String userId = userDocument.id;
          Map<String, dynamic> userData = userDocument.data();
          usersData[userId] = userData;
        }

        // Récupérer les documents de la collection "posts"
        var postsSnapshot =
            await FirebaseFirestore.instance.collection("posts").get();

        for (var postDocument in postsSnapshot.docs) {
          String postUserId = postDocument["posts_users"];
          String postId = postDocument.id;

          // Associer le document "posts" à l'utilisateur correspondant
          if (usersData.containsKey(postUserId)) {
            Map<String, dynamic> userData = usersData[postUserId]!;
            Map<String, dynamic> mapData = {
              "posts_ID": postId,
              "users_name": userData["users_name"],
              // "posts_users": postDocument.data()['posts_users'],
              // "posts_date": postDocument.data()['posts_date'],
              // "posts_title": postDocument.data()['posts_title'],
              // "posts_text": postDocument.data()['posts_text'],
              // "posts_image": postDocument.data()['posts_image'],
            };
            mapData.addAll(postDocument.data());
            data.add(mapData);
          }
        }
        return Right(data);
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }

  // Lire les données d'un document
  Future<Either<StatusRequest, Map<String, dynamic>>> getDocInfo(
      String collection, String docID) async {
    try {
      if (await checkInternet()) {
        // Effectuez une requête Firestore en fonction des paramètres fournis
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await _firebaseFirestore.collection(collection).doc(docID).get();
        Map<String, dynamic> data = documentSnapshot.data()!;
        return Right(data);
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  // Modifier les données sans modifier l'image
  Future<Either<StatusRequest, Map<String, dynamic>>> updateData(
      String collection, String documentId, Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore
          .collection(collection)
          .doc(documentId)
          .update(data);
      return Right(data);
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  // Modifier des données avec image
  Future<Either<StatusRequest, Map<String, dynamic>>> updateDataWithImage(
      String collection,
      String documentId,
      Map<String, dynamic> data,
      File? image) async {
    try {
      await _firebaseFirestore
          .collection(collection)
          .doc(documentId)
          .update(data);

      if (image != null) {
        String imagePath = 'images/$documentId.jpg';
        await _uploadImage(image, imagePath);
        String imageUrl = await _getImageUrl(imagePath);
        Map<String, dynamic> updatedData = {'image_url': imageUrl};
        await _firebaseFirestore
            .collection(collection)
            .doc(documentId)
            .update(updatedData);
        return Right({...data, ...updatedData});
      }

      return Right(data);
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  // Supprimer les données
  Future<Either<StatusRequest, bool>> deleteData(
      String collection, String documentId) async {
    try {
      await _firebaseFirestore.collection(collection).doc(documentId).delete();
      return const Right(true);
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  // Méthode pour télécharger une image dans le stockage Firebase
  Future<void> _uploadImage(File image, String imagePath) async {
    await FirebaseStorage.instance.ref().child(imagePath).putFile(image);
  }

  // Méthode pour obtenir l'URL d'une image depuis le stockage Firebase
  Future<String> _getImageUrl(String imagePath) async {
    return await FirebaseStorage.instance.ref(imagePath).getDownloadURL();
  }
}
