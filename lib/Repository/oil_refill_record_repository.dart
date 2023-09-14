import 'package:car_app/model/crud_base.dart';
import 'package:car_app/model/dto/oil_refill_record_dto.dart';
import 'package:car_app/model/oil_refill_record_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OilRefillRecordRepository implements CRUDBase {

  @override
  Future<void> addData(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(String id) {
    // TODO: implement deleteData
    throw UnimplementedError();
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