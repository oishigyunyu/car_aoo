import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CRUDBase {
  Stream<QuerySnapshot> getCollection();

  Future<void> addData(Map<String, dynamic> data);

  Future<void> updateData(String id, Map<String, dynamic> data);

  Future<void> deleteData(String id);
}