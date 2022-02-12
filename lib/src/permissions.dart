import 'package:geolocator/geolocator.dart';

/// retPermission.index = 0 : LocationPermission.denied
///
/// retPermission.index = 1 : LocationPermission.deniedForever
///
/// retPermission.index = 2 : LocationPermission.whileInUse
///
/// retPermission.index = 3 : LocationPermission.always
Future<LocationPermission> checkAndAskPosition() async {
  LocationPermission retPermission;

  retPermission = await Geolocator.checkPermission();
  if (retPermission.index < 2)
    retPermission = await Geolocator.requestPermission();

  return retPermission;
}
