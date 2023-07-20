import 'package:isar/isar.dart';

abstract class BaseIsarReporitories<T> {
  late Future<Isar> db;
  BaseIsarReporitories() {
    db = openDB();
  }

  Future<void> saveIsar(T tModel);

  Future<List<T>> getAllIsar();

  Future<void> deleteByIndex(int index);

  Future<void> deleteAllIsar(List<int> listTIsar);

  Future<Isar> openDB();
}
