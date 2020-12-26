import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = Firestore.instance.document(path);
    print('$path: $data');
    await reference.setData(data, merge: merge);
  }

  Future<void> deleteData({@required String path}) async {
    final reference = Firestore.instance.document(path);
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data) builder,
    Query Function(Query query) queryBuilder,
    int Function(T lhs, T rhs) sort,
  }) {
    //final startAtTimestamp = Timestamp.fromMillisecondsSinceEpoch(DateTime.parse('19 de mayo de 2020, 18:29:35 UTC-5').millisecondsSinceEpoch);

    //Query query = Firestore.instance.collection(path).where("id", isEqualTo: "dsdas");
    //Query query = Firestore.instance.collection(path).orderBy("id").startAt(["2020-05-20"]);
    Query query = Firestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.documents
          .map((snapshot) {
            return builder(snapshot.data);       
          })
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    }
    );
  }
  Stream<List<T>> lastCollectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data) builder,
    Query Function(Query query) queryBuilder,
    int Function(T lhs, T rhs) sort,
  }) {
    Query query = Firestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.documents
          .map((snapshot) {
            return builder(snapshot.data);       
          })
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    }
    );
  }
  Stream<T> documentStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final DocumentReference reference = Firestore.instance.document(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => builder(snapshot.data, snapshot.documentID));
  }
}