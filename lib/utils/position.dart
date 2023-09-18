import 'package:geocoding/geocoding.dart' as geo_coding;
import 'package:geolocator/geolocator.dart';

Future<Map<String, String>> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.'
    );
  }

  final position = await Geolocator.getCurrentPosition();
  final placeMarks = await geo_coding.placemarkFromCoordinates(position.latitude, position.longitude);
  final placeMark = placeMarks[0];
  String locality = placeMark.locality ?? '';
  String administrativeArea = placeMark.administrativeArea ?? '';
  return {
    'locality': locality,
    'administrativeArea': administrativeArea,
  };
}