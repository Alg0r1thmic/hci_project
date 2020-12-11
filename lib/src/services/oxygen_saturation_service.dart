import 'package:flutter/foundation.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';
import '../models/oxygen_saturation_model.dart';

class OxygenSaturationService {
  final _firestoreService = FirestoreService.instance;

  //Method to retrieve all oxygenSaturations  
  Stream<List<OxygenSaturationModel>> oxygenSaturationsStream() => _firestoreService.collectionStream(
        path: FirestorePath.oxygenSaturations(),
        builder: (data) => OxygenSaturationModel.fromJson(data),
  );
  //Method to create/update OxygenSaturation
  Future<void> setOxygenSaturation(OxygenSaturationModel model) async => await _firestoreService.setData(
        path: FirestorePath.oxygenSaturation(model.id),
        data: model.toJson(),
  );
  //Method to delete OxygenSaturationModel entry
  Future<void> deleteOxygenSaturation(OxygenSaturationModel model) async {
    await _firestoreService.deleteData(path: FirestorePath.oxygenSaturation(model.id));
  }

  //Method to retrieve OxygenSaturation object based on the given Id
  Stream<OxygenSaturationModel> oxygenSaturationStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.oxygenSaturation(id),
        builder: (data, documentId) => OxygenSaturationModel.fromJson(data),
  );
}
