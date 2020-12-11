
import 'package:flutter/foundation.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';
import '../models/temperature_model.dart';

class TemperatureService {
  final _firestoreService = FirestoreService.instance;

  //Method to retrieve all temperatures  
  Stream<List<TemperatureModel>> temperaturesStream() => _firestoreService.collectionStream(
        path: FirestorePath.temperatures(),
        builder: (data) => TemperatureModel.fromJson(data),
  );
  //Method to create/update Temperature
  Future<void> setTemperature(TemperatureModel model) async => await _firestoreService.setData(
        path: FirestorePath.temperature(model.id),
        data: model.toJson(),
  );
  //Method to delete TemperatureModel entry
  Future<void> deleteTemperature(TemperatureModel model) async {
    await _firestoreService.deleteData(path: FirestorePath.temperature(model.id));
  }

  //Method to retrieve Temperature object based on the given Id
  Stream<TemperatureModel> temperatureStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.temperature(id),
        builder: (data, documentId) => TemperatureModel.fromJson(data),
  );
}
