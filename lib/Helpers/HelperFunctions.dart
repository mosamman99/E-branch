import 'package:ebranch/Screens/AuthScreens/LoginScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:geolocator/geolocator.dart';

import 'Navigation.dart';

toast(msg,context){
  Toast.show(msg, context,gravity: 1,duration: 2);
}


// Retrieve string data stored
Future<String> getSavedString(String value,String defaultVal) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String savedValue = _prefs.getString(value) ?? defaultVal;
  return savedValue;
}

// Store String data
Future<bool> setSavedString(String key,String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool savedValue =await _prefs.setString(key,value);
  return savedValue;
}

logOut(context) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.clear();
  Navigation.ReplacementNavigator(context, LoginScreen());
}

// get current location

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


Future<String> getToken() async{
  String fcm = await FirebaseMessaging.instance.getToken();
  return fcm;
}
