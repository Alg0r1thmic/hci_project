import 'package:flutter/foundation.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';
import '../models/temperature_model.dart';
import 'base.service.dart';

class TemperatureService implements BaseService<TemperatureModel> {
  final _firestoreService = FirestoreService.instance;  
   //Method to retrieve all temperatures  
  @override
  Stream<List<TemperatureModel>> findAllStream() => _firestoreService.collectionStream(
        path: FirestorePath.temperatures(),
        builder: (data) => TemperatureModel.fromJson(data),
  );
  //Method to retrieve Imc object based on the given Id
  @override
  Stream<TemperatureModel> findOneStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.temperature(id),
        builder: (data, documentId) => TemperatureModel.fromJson(data),
  );
  //Method to create/update Imc
  @override
  Future<void> createOne(TemperatureModel model) async => await _firestoreService.setData(
        path: FirestorePath.temperature(model.id.toString()),
        data: model.toJson(),
  );
  //Method to delete TemperatureModel entry
  @override
  Future<void> deleteOne(TemperatureModel model) async {
    await _firestoreService.deleteData(path: FirestorePath.temperature(model.id.toString()));
  }

  @override
  Stream<List<TemperatureModel>> lastDocumentsStream(int n) => _firestoreService.collectionStream(
        path: FirestorePath.temperatures(),
        builder: (data) => TemperatureModel.fromJson(data),
        queryBuilder: (query) => query.orderBy('id',descending: true).limit(n)
  );
}
