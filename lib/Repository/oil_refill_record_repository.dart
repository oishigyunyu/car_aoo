import 'package:car_app/model/crud_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class OilRefillRecordRepository implements CRUDBase {

  const OilRefillRecordRepository();

  @override
  Future<void> addData(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(String id) async {
    // TODO: implement deleteData
    try {
      db
          .collection('CAR_MAINTENANCE')
          .doc('OIL_REFILL_RECORD')
          .collection('RECORDS')
          .doc(id+'sssss')
          .delete();
    } on FirebaseException catch (e) {
      rethrow;
    }

  }

  @override
  Future<CollectionReference<Map<String, dynamic>>> getCollection() {
    // TODO: implement getCollection
    throw UnimplementedError();
  }

  @override
  Future<void> updateData(String id, Map<String, dynamic> data) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}