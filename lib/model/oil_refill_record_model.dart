import 'package:car_app/model/crud_base.dart';
import 'package:car_app/view/oil_refill_record_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class OilRefillRecordCRUD implements CRUDBase {

  @override
  Future<CollectionReference<Map<String, dynamic>>> getCollection() async {
    final collectionRef = db
        .collection('CAR_MAINTENANCE')
        .doc('OIL_REFILL_RECORD')
        .collection('RECORDS');
    return collectionRef;
  }

  @override
  Future<dynamic> addData(Map<String, dynamic> data) async {
    try {
      final collectionRef = db
          .collection('CAR_MAINTENANCE')
          .doc('OIL_REFILL_RECORD')
          .collection('RECORDS');
      await collectionRef.doc().set({
        'refillDate': dto.date,
        'grade': dto.grade,
        'brandName': dto.brandName,
        'totalDistance': dto.totalDistance,
        'createdAt': DateTime.now()
      });

      return 1;

    } on FirebaseException catch (e) {
      return e;
    }
  }

  @override
  Future<void> deleteData(String id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<void> updateData(String id, Map<String, dynamic> data) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}