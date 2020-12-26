
import 'package:flutter/foundation.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';
import '../models/questions_model.dart';

class QuestionsService {
  final _firestoreService = FirestoreService.instance;

  //Method to retrieve all questions  
  Stream<List<QuestionsModel>> questionsStream() => _firestoreService.collectionStream(
        path: FirestorePath.questions(),
        builder: (data) => QuestionsModel.fromJson(data),
  );
  //Method to create/update Question
  Future<void> setQuestion(QuestionsModel model) async => await _firestoreService.setData(
        path: FirestorePath.question(model.id),
        data: model.toJson(),
  );
  //Method to delete QuestionsModel entry
  Future<void> deleteQuestion(QuestionsModel model) async {
    await _firestoreService.deleteData(path: FirestorePath.question(model.id));
  }

  //Method to retrieve Question object based on the given Id
  Stream<QuestionsModel> questionStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.question(id),
        builder: (data, documentId) => QuestionsModel.fromJson(data),
  );
}
