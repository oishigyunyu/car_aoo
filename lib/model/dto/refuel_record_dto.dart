import '../refuel_record_model.dart';

class RefuelRecordDTO {
  RefuelRecordDTO(
      {required this.date,
        required this.fuelQuantity,
        required this.unitPrice,
        required this.droveDistanceFromLastRefuel,
        required this.createdAt});

  final DateTime date;
  final double fuelQuantity;
  final double unitPrice;
  final double droveDistanceFromLastRefuel;
  final DateTime createdAt;

  factory RefuelRecordDTO.fromModel(RefuelRecordModel record) {
    return RefuelRecordDTO(
        date: record.date,
        fuelQuantity: record.fuelQuantity,
        unitPrice: record.unitPrice,
        droveDistanceFromLastRefuel: record.droveDistanceFromLastRefuel,
        createdAt: DateTime.now()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'fuelQuantity': fuelQuantity,
      'unitPrice' : unitPrice,
      'droveDistanceFromLastRefuel': droveDistanceFromLastRefuel
    };
  }

}