import 'package:flutter/material.dart';
import 'package:absentee/Utils/SharedPreferencesHelper.dart';
import 'package:flutter/services.dart';
import 'package:absentee/Pages/SignInScreen.dart';
var routes = <String, WidgetBuilder>{
  "/signin": (BuildContext context) => LoginPage(),
};
void main() async {
  // Set default home.
  Widget _defaultHome =  LoginPage();
  // Get result of the login function.
  String siteId = await SharedPreferencesHelper.getSiteId();
  String authToken = await SharedPreferencesHelper.getAuth_Token();
  String apikey = await SharedPreferencesHelper.getApi_key();
  if (siteId.length > 0 && authToken.length > 0 && apikey.length > 0) {
    _defaultHome =  LoginPage();
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