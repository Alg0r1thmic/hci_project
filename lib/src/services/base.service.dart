import 'package:flutter/foundation.dart';

abstract class BaseService<T> {
  Stream<List<T>> findAllStream();
  Future<void> createOne(T model);
  Future<void> deleteOne(T model);
  Stream<T> findOneStream({@required String id});
}