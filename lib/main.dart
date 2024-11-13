import 'package:valetparking_user/utils/constants/exports.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Bloc.observer = MyBlocObserver();
//   DioHelper.init();
//   VDeviceUtils.initCacheHelper();
//   VDeviceUtils.setStatusBarColor(Colors.white);
//   VDeviceUtils.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   await LocationHelper.getMyCurrentLocation();
//   runApp(const ValetParkingApp());
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart'; // Import the Geolocator package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  VDeviceUtils.initCacheHelper();
  VDeviceUtils.setStatusBarColor(Colors.white);
  VDeviceUtils.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await checkLocationStatus();
  runApp(const ValetParkingApp());
}

Future<void> checkLocationStatus() async {
  // Check if location services are enabled
  bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

  if (!isLocationEnabled) {
    // If location services are not enabled, open the location settings to prompt the user
    await Geolocator.openLocationSettings();
  }

  // Check and request location permissions
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    // Request permission if it's denied or denied forever
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      // If still denied, you can handle the refusal here (e.g., show a message to the user)
      print('Location permission denied');
      return;
    }
  }

  // If permissions are granted, get the current location
  await LocationHelper.getMyCurrentLocation();
}