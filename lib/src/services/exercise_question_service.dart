import 'package:flutter/foundation.dart';
import 'package:health_body_checking/src/core/db/firebase_path.dart';
import 'package:health_body_checking/src/core/db/firebase_service.dart';
import 'package:health_body_checking/src/models/exercise_question_model.dart';
import 'package:health_body_checking/src/services/base.service.dart';

class ExerciseQuestionService implements BaseService<ExerciseQuestionModel> {
  final _firestoreService = FirestoreService.instance;
  //Method to retrieve all exerciseQuestions
  @override
  Stream<List<ExerciseQuestionModel>> findAllStream() =>
      _firestoreService.collectionStream(
        path: FirestorePath.exerciseQuestions(),
        builder: (data) => ExerciseQuestionModel.fromJson(data),
      );
  Stream<List<ExerciseQuestionModel>> findByUserId({@required String userId}) =>
      _firestoreService.collectionStream(
          path: FirestorePath.exerciseQuestions(),
          builder: (data) => ExerciseQuestionModel.fromJson(data),
          queryBuilder: (query) => query.where('userId', isEqualTo: userId));
  //Method to retrieve ExerciseQuestionModel object based on the given Id
  @override
  Stream<ExerciseQuestionModel> findOneStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.exerciseQuestion(id),
        builder: (data, documentId) => ExerciseQuestionModel.fromJson(data),
      );
  //Method to create/update ExerciseQuestionModel
  @override
  Future<void> createOne(ExerciseQuestionModel model) async {
    this.findByUserId(userId: model.userId).listen((event) async{ 
      if(event.length==0){
        await _firestoreService.setData(
          path: FirestorePath.exerciseQuestion(model.id.toString()),
          data: model.toJson(),
        );
      }
    });  
  }

  //Method to delete ExerciseQuestionModel entry
  @override
  Future<void> deleteOne(ExerciseQuestionModel model) async {
    await _firestoreService.deleteData(
        path: FirestorePath.exerciseQuestion(model.id.toString()));
  }

  @override
  Stream<List<ExerciseQuestionModel>> lastDocumentsStream(int n) =>
      _firestoreService.collectionStream(
          path: FirestorePath.exerciseQuestions(),
          builder: (data) => ExerciseQuestionModel.fromJson(data),
          queryBuilder: (query) =>
              query.orderBy('id', descending: true).limit(n));
}
