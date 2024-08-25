import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check location permission status
    LocationPermission permission = await Geolocator.checkPermission();

    // Request permission if it is denied
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    // Handle permanently denied permission
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied. We cannot request permissions.');
    }

    // At this point, permission is granted
    return await Geolocator.getCurrentPosition();
  }
}
