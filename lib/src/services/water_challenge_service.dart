import 'package:flutter/foundation.dart';
import 'package:health_body_checking/src/models/water_challenge_model.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';
import 'base.service.dart';

class WaterChallengeService implements BaseService<WaterChallengeModel> {
  final _firestoreService = FirestoreService.instance;  
   //Method to retrieve all waterChallenges  
  @override
  Stream<List<WaterChallengeModel>> findAllStream() => _firestoreService.collectionStream(
        path: FirestorePath.waterChallenges(),
        builder: (data) => WaterChallengeModel.fromJson(data),
  );
  Stream<List<WaterChallengeModel>> findByUserId({@required String userId}) => _firestoreService.collectionStream(
        path: FirestorePath.waterChallenges(),
        builder: (data) => WaterChallengeModel.fromJson(data),
        queryBuilder: (query) => query.where('userId',isEqualTo: userId)
  );
  //Method to retrieve WaterChallengeModel object based on the given Id
  @override
  Stream<WaterChallengeModel> findOneStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.waterChallenge(id),
        builder: (data, documentId) => WaterChallengeModel.fromJson(data),
  );
  //Method to create/update WaterChallengeModel
  @override
  Future<void> createOne(WaterChallengeModel model) async => await _firestoreService.setData(
        path: FirestorePath.waterChallenge(model.id.toString()),
        data: model.toJson(),
  );
  //Method to delete WaterChallengeModel entry
  @override
  Future<void> deleteOne(WaterChallengeModel model) async {
    await _firestoreService.deleteData(path: FirestorePath.waterChallenge(model.id.toString()));
  }

  @override
  Stream<List<WaterChallengeModel>> lastDocumentsStream(int n) => _firestoreService.collectionStream(
        path: FirestorePath.waterChallenges(),
        builder: (data) => WaterChallengeModel.fromJson(data),
        queryBuilder: (query) => query.orderBy('id',descending: true).limit(n)
  );
}
