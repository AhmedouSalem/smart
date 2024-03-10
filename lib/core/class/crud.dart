import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
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
}
