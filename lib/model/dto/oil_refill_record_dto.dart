import 'package:car_app/model/oil_refill_record_model.dart';

class OilRefillRecordDTO {
  OilRefillRecordDTO(
      {required this.date,
        required this.grade,
        required this.brandName,
        required this.totalDistance,
        required this.createdAt});

  final DateTime date;
  final String grade;
  final String brandName;
  final double totalDistance;
  final DateTime createdAt;

  factory OilRefillRecordDTO.fromModel(OilRefillRecordModel record) {
    return OilRefillRecordDTO(
      date: record.date,
      grade: record.grade,
      brandName: record.brandName,
      totalDistance: record.totalDistance,
      createdAt: DateTime.now()
    );
  }
}