import 'package:location/location.dart';

// class LocationManager {
//   static late LocationManager _instance;
//   static LocationManager get instance => _instance;

//   static final Location _currentLocation = Location();
//   static late LocationData _location;
//   static Future<void> init() async {
//     await getLocation();
//   }

//   static Future<LocationData> getLocation() async {
//     try {
//       Map<Permission, PermissionStatus> status = await [
//         Permission._location,
//         Permission.storage,
//       ].request();
//       _location = await _currentLocation.getLocation();
//       return _location;
//     } on Exception catch (e) {
//       log(e.toString());
//       return _location;
//     }
//   }
// }

class LocationManager {
  static final Location _location = Location();

  static late bool _serviceEnabled;
  static late PermissionStatus _permissionGranted;
  static late LocationData _locationData;

  static LocationData get location => _locationData;

  static Future<void> getLocation() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }

    _locationData = await _location.getLocation();
  }
}
