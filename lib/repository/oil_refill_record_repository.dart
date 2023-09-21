import 'package:car_app/repository/crud_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class OilRefillRecordRepository implements CRUDBase {

  const OilRefillRecordRepository();

  @override
  Future<void> addData(Map<String, dynamic> data) async {
    db
        .collection('CAR_MAINTENANCE')
        .doc('OIL_REFILL_RECORD')
        .collection('RECORDS')
        .doc().set({
          'refillDate': data['refillDate'],
          'grade': data['grade'],
          'brandName': data['brandName'],
          'totalDistance': data['totalDistance'],
          'createdAt': DateTime.now()});
  }

  @override
  Future<void> deleteData(String id) async {
    // TODO: implement deleteData
    db
          .collection('CAR_MAINTENANCE')
          .doc('OIL_REFILL_RECORD')
          .collection('RECORDS')
          .doc(id)
          .delete();
  }

  @override
  Stream<QuerySnapshot> getCollection() {
    return db
        .collection('CAR_MAINTENANCE')
        .doc('OIL_REFILL_RECORD')
        .collection('RECORDS')
        .orderBy('refillDate', descending: true)
        .snapshots();
  }

  @override
  Future<void> updateData(String id, Map<String, dynamic> data) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}