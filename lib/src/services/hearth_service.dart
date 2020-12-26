import 'package:flutter/foundation.dart';
import 'package:health_body_checking/src/models/hearth_rate_model.dart';
import 'package:health_body_checking/src/services/base.service.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';

class HearthRateService implements BaseService<HearthRateModel> {
  final _firestoreService = FirestoreService.instance;  
   //Method to retrieve all hearthRates  
  @override
  Stream<List<HearthRateModel>> findAllStream() => _firestoreService.collectionStream(
        path: FirestorePath.hearthRates(),
        builder: (data) => HearthRateModel.fromJson(data),
  );
  //Method to retrieve Imc object based on the given Id
  @override
  Stream<HearthRateModel> findOneStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.hearthRate(id),
        builder: (data, documentId) => HearthRateModel.fromJson(data),
  );
  //Method to create/update Imc
  @override
  Future<void> createOne(HearthRateModel model) async => await _firestoreService.setData(
        path: FirestorePath.hearthRate(model.id.toString()),
        data: model.toJson(),
  );
  //Method to delete HearthRateModel entry
  @override
  Future<void> deleteOne(HearthRateModel model) async {
    await _firestoreService.deleteData(path: FirestorePath.hearthRate(model.id.toString()));
  }

  @override
  Stream<List<HearthRateModel>> lastDocumentsStream(int n) => _firestoreService.collectionStream(
        path: FirestorePath.hearthRates(),
        builder: (data) => HearthRateModel.fromJson(data),
        queryBuilder: (query) => query.orderBy('id',descending: true).limit(n)
  );
}
