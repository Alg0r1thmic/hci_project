import 'package:flutter/foundation.dart';
import 'package:health_body_checking/src/services/base.service.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';
import '../models/oxygen_saturation_model.dart';

class OxygenSaturationService implements BaseService<OxygenSaturationModel> {
  final _firestoreService = FirestoreService.instance;  
   //Method to retrieve all oxygenSaturations  
  @override
  Stream<List<OxygenSaturationModel>> findAllStream() => _firestoreService.collectionStream(
        path: FirestorePath.oxygenSaturations(),
        builder: (data) => OxygenSaturationModel.fromJson(data),
  );
  //Method to retrieve OxygenSaturation object based on the given Id
  @override
  Stream<OxygenSaturationModel> findOneStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.oxygenSaturation(id),
        builder: (data, documentId) => OxygenSaturationModel.fromJson(data),
  );
  //Method to create/update OxygenSaturation
  @override
  Future<void> createOne(OxygenSaturationModel model) async => await _firestoreService.setData(
        path: FirestorePath.oxygenSaturation(model.id.toString()),
        data: model.toJson(),
  );
  //Method to delete OxygenSaturationModel entry
  @override
  Future<void> deleteOne(OxygenSaturationModel model) async {
    await _firestoreService.deleteData(path: FirestorePath.oxygenSaturation(model.id.toString()));
  }

  @override
  Stream<List<OxygenSaturationModel>> lastDocumentsStream(int n) => _firestoreService.collectionStream(
        path: FirestorePath.oxygenSaturations(),
        builder: (data) => OxygenSaturationModel.fromJson(data),
        queryBuilder: (query) => query.orderBy('id',descending: true).limit(n)
  );
}
