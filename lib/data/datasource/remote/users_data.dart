import 'package:dartz/dartz.dart';
import 'package:smart_training/core/class/crud.dart';
import 'package:smart_training/core/class/statusrequest.dart';

class UsersData {
  Crud crud;
  UsersData(
    this.crud,
  );

  getUsers(String collection, String docID) async {
    Either<StatusRequest, Map<String, dynamic>> response =
        await crud.getDocInfo(
      collection,
      docID,
    );
    return response.fold((l) => l, (r) => r);
  }
}
