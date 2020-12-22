
import 'package:flutter/foundation.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';
import '../models/user_model.dart';

class UserService {
  final _firestoreService = FirestoreService.instance;

  //Method to create/update user
  Future<void> setUser(CurrentUserModel model) async => await _firestoreService.setData(
        path: FirestorePath.user(model.id),
        data: model.toJson(),
  );


  //Method to retrieve User object based on the given Id
  Stream<CurrentUserModel> userStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.user(id),
        builder: (data, documentId) => CurrentUserModel.fromJson(data),
  );
}
