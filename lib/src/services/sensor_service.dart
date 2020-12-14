
import 'package:flutter/foundation.dart';
import 'package:health_body_checking/src/models/sensor_model.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';
import '../models/sensor_model.dart';

class SensorService {
  final _firestoreService = FirestoreService.instance;

  //Method to retrieve all sensors  
  Stream<List<SensorModel>> sensorsStream() => _firestoreService.collectionStream(
        path: FirestorePath.sensors(),
        builder: (data) => SensorModel.fromJson(data),
  );
  //Method to create/update Sensor
  Future<void> setSensor(SensorModel model) async => await _firestoreService.setData(
        path: FirestorePath.sensor(model.id),
        data: model.toJson(),
  );
  //Method to delete SensorModel entry
  Future<void> deleteSensor(SensorModel model) async {
    await _firestoreService.deleteData(path: FirestorePath.sensor(model.id));
  }

  //Method to retrieve Sensor object based on the given Id
  Stream<SensorModel> sensorStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.sensor(id),
        builder: (data, documentId) => SensorModel.fromJson(data),
  );
}
