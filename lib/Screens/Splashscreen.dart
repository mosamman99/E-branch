import 'package:another_flushbar/flushbar.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:ebranch/Helpers/Navigation.dart';
import 'package:ebranch/Screens/HomeScreens/HomeScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../Helpers/Config.dart';
import 'AuthScreens/LoginScreen.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),() async {
      String jwt  = await getSavedString("jwt", "");
      Navigation.removeUntilNavigator(context, jwt==""?LoginScreen():HomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("images/logo.png",height: 200,width: 200,fit: BoxFit.fill,),
      ),
    );
  }


}
