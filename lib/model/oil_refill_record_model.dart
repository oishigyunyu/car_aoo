class OilRefillRecordModel{
  final DateTime date;
  final String grade;
  final String brandName;
  final double totalDistance;

  OilRefillRecordModel(Map<String, dynamic> data, 
      {required this.date,
        required this.grade,
        required this.brandName,
        required this.totalDistance});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'grade': grade,
      'brandName': brandName,
      'totalDistance': totalDistance
    };
  }
}