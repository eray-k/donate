import 'package:geolocator/geolocator.dart';
import '../../../../auth/domain/model/position.dart' as model;

class LocationService {
  const LocationService();

  Future<bool> handlePermissions() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
      //Future.error('Location services are disabled.'); //FIXME: Add error handling
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
        //return Future.error('Location permissions are denied'); //FIXME: Add error handling
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
      //Future.error('Location permissions are permanently denied, we cannot request permissions.'); //FIXME: Add error handling
    }
    return true;
  }

  Future<model.Position> getLocation() async {
    await handlePermissions();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final data = await Geolocator.getCurrentPosition();
    return model.Position(
        latitude: data.latitude,
        longitude: data.longitude,
        timestamp: DateTime.now());
  }
}
