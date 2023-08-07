import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class LocationService {
  Future<Position> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      throw "Error getting location: $e";
    }
  }

  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      return "${placemarks.first.subThoroughfare} "
          "${placemarks.first.thoroughfare}, "
          "${placemarks.first.locality}, "
          "${placemarks.first.administrativeArea}, "
          "${placemarks.first.country}";
    } catch (e) {
      throw "Error getting address: $e";
    }
  }
}
