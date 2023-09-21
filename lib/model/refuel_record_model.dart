class RefuelRecordModel {
  RefuelRecordModel(
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

}