import 'package:flutter/foundation.dart';

import '../core/db/firebase_path.dart';
import '../core/db/firebase_service.dart';
import '../models/imc_model.dart';
import 'base.service.dart';

class ImcService implements BaseService<ImcModel> {
  final _firestoreService = FirestoreService.instance;  
   //Method to retrieve all imcs  
  @override
  Stream<List<ImcModel>> findAllStream() => _firestoreService.collectionStream(
        path: FirestorePath.imcs(),
        builder: (data) => ImcModel.fromJson(data),
  );
  //Method to retrieve Imc object based on the given Id
  @override
  Stream<ImcModel> findOneStream({@required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.imc(id),
        builder: (data, documentId) => ImcModel.fromJson(data),
  );
  //Method to create/update Imc
  @override
  Future<void> createOne(ImcModel model) async => await _firestoreService.setData(
        path: FirestorePath.imc(model.id.toString()),
        data: model.toJson(),
  );
  //Method to delete ImcModel entry
  @override
  Future<void> deleteOne(ImcModel model) async {
    await _firestoreService.deleteData(path: FirestorePath.imc(model.id.toString()));
  }

  @override
  Stream<List<ImcModel>> lastDocumentsStream(int n) => _firestoreService.collectionStream(
        path: FirestorePath.imcs(),
        builder: (data) => ImcModel.fromJson(data),
        queryBuilder: (query) => query.orderBy('id',descending: true).limit(n)
  );
}
