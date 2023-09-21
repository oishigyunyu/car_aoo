import 'package:car_app/repository/crud_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class RefuelRecordRepository implements CRUDBase {

  const RefuelRecordRepository();

  @override
  Future<void> addData(Map<String, dynamic> data) async {
    db
        .collection('CAR_MAINTENANCE')
        .doc('REFUEL_RECORD')
        .collection('RECORDS')
        .doc().set({
      'refuelDate': data['date'],
      'fuelQuantity': data['fuelQuantity'],
      'unitPrice': data['unitPrice'],
      'droveDistanceFromLastRefuel': data['droveDistanceFromLastRefuel'],
      'createdAt': DateTime.now()
    });
  }

  @override
  Future<void> deleteData(String id) async {
    return db
        .collection('CAR_MAINTENANCE')
        .doc('REFUEL_RECORD')
        .collection('RECORDS')
        .doc(id)
        .delete();
  }

  @override
  Stream<QuerySnapshot> getCollection() {
    // TODO: implement getCollection
    return db
        .collection('CAR_MAINTENANCE')
        .doc('REFUEL_RECORD')
        .collection('RECORDS')
        .orderBy('refuelDate', descending: true)
        .snapshots();
  }

  @override
  Future<void> updateData(String id, Map<String, dynamic> data) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
  
}