import 'package:flutter/foundation.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';
import '../models/exercise_challenge_model.dart';
import 'base.service.dart';

class ExerciseChallengeService implements BaseService<ExerciseChallengeModel> {
  final _firestoreService = FirestoreService.instance;  
   //Method to retrieve all exerciseChallenges  
  @override
  Stream<List<ExerciseChallengeModel>> findAllStream() => _firestoreService.collectionStream(
        path: FirestorePath.exerciseChallenges(),
        builder: (data) => ExerciseChallengeModel.fromJson(data),
  );
  Stream<List<ExerciseChallengeModel>> findByUserId({@required String userId}) => _firestoreService.collectionStream(
        path: FirestorePath.exerciseChallenges(),
        builder: (data) => ExerciseChallengeModel.fromJson(data),
        queryBuilder: (query) => query.where('userId',isEqualTo: userId)
  );
  //Method to retrieve ExerciseChallengeModel object based on the given Id
  @override
  Stream<ExerciseChallengeModel> findOneStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.exerciseChallenge(id),
        builder: (data, documentId) => ExerciseChallengeModel.fromJson(data),
  );
  //Method to create/update ExerciseChallengeModel
  @override
  Future<void> createOne(ExerciseChallengeModel model) async => await _firestoreService.setData(
        path: FirestorePath.exerciseChallenge(model.id.toString()),
        data: model.toJson(),
  );
  //Method to delete ExerciseChallengeModel entry
  @override
  Future<void> deleteOne(ExerciseChallengeModel model) async {
    await _firestoreService.deleteData(path: FirestorePath.exerciseChallenge(model.id.toString()));
  }

  @override
  Stream<List<ExerciseChallengeModel>> lastDocumentsStream(int n) => _firestoreService.collectionStream(
        path: FirestorePath.exerciseChallenges(),
        builder: (data) => ExerciseChallengeModel.fromJson(data),
        queryBuilder: (query) => query.orderBy('id',descending: true).limit(n)
  );
}
