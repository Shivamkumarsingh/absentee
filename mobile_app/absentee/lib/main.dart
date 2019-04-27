import 'package:flutter/material.dart';
import 'package:absentee/Utils/SharedPreferencesHelper.dart';
import 'package:flutter/services.dart';
import 'package:absentee/Pages/SignInScreen.dart';
import 'package:absentee/Pages/HomeScreen.dart';
var routes = <String, WidgetBuilder>{
  "/signin": (BuildContext context) => LoginPage(),
  "/home": (BuildContext context) => HomeScreen(),
};
void main() async {
  // Set default home.
  Widget _defaultHome =  LoginPage();
  // Get result of the login function.
  String authToken = await SharedPreferencesHelper.getAuth_Token();
  if (authToken.length > 0) {
    _defaultHome =  HomeScreen();
  }

  // Run app!
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(new MaterialApp(
    title: 'App',
    debugShowCheckedModeBanner: false,
    home: _defaultHome, // SplashScreen()
    routes: routes,
  ));
}