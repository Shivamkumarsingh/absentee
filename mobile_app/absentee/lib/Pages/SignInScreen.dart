import 'package:absentee/Utils/Constant.dart';
import 'package:flutter/material.dart';
import 'package:absentee/Utils/my_navigator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:absentee/Models/UserModel.dart';
import 'package:absentee/Utils/SharedPreferencesHelper.dart';
import 'package:absentee/Utils/Connectivity.dart';
class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isLoading = false;
  NetworkCheck networkCheck = NetworkCheck();

  Future getSignInResponse(String usernameText, String passwordText) async {
    setState(() {
      isLoading = true;
    });

     Map map = {
       'session[login]': usernameText,
       'session[password]': passwordText,
       'session[device_id]': 'Mobile',
       'third_party_apps': 'acufire',
       'user_login': 'true',
    //   'session[notification_token]':" "
     };
     print(map);
     // Await the http get response, then decode the json-formatted response.
     await http.post(Constant.signInAPI, body: map, headers: {
       'Accept': 'application/vnd.simplysmart.v1+json',
       'Content-Type': 'application/x-www-form-urlencoded'
     }).then((http.Response response){
       if (response.statusCode == 200) {
         var jsonResponse = jsonDecode(response.body);
         var authenticated = jsonResponse['authenticated'];
         var message = jsonResponse['message'];
         if (authenticated == true && message == "Signed in successfully.") {
           var data = jsonResponse['data'];
           var user = data['user'];

           User userObject = User.fromJson(user);
           SharedPreferencesHelper.setUserID(userObject.id);
           SharedPreferencesHelper.setUserName(userObject.username);
           SharedPreferencesHelper.setUser(userObject.name);
           SharedPreferencesHelper.setApi_key(userObject.api_key);
           SharedPreferencesHelper.setAuth_Token(userObject.auth_Token);
           SharedPreferencesHelper.setEmail(userObject.email);
           SharedPreferencesHelper.setRole_code(userObject.role_code);
           SharedPreferencesHelper.setCompany_Subdomain(userObject.company.subdomain);
           String sites = json.encode(user["sites"]);
           SharedPreferencesHelper.setSiteId(sites);
           setState(() {
             isLoading = false;
           });
           print(sites);
           MyNavigator.goToHome(context);
         }
       } else {
         setState(() {
           isLoading = false;
         });
         print("Request failed with status: ${response.statusCode}.");
         print("Error:${response.reasonPhrase}");
         print("Response:${response.body}");
         var jsonResponse = jsonDecode(response.body);
         var itemCount = jsonResponse['message'];
         Constant().showDialogBox(context,"Log in Failed", "Error : $itemCount");
       }
     })
         .catchError((error){
       setState(() {
         isLoading = false;
       });
       Constant().showDialogBox(context,"Log in Failed", "Error : $error");

     });



  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    final logo = Hero(
        tag: 'hero',
        child: Image.asset("assets/images/app_icon.png", fit: BoxFit.fitHeight,
            width: 80,
            height: 100));

    final email = TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      // initialValue: '',
      decoration: InputDecoration(
        hintText: 'User ID',
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      // initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        onPressed: () {
          if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
            networkCheck.checkInternet((isNetworkPresent) {
              if(isNetworkPresent) {
                // getSignInResponse(_usernameController.text, _passwordController.text);
                 MyNavigator.goToHome(context);
              }else{
                Constant().showDialogBox(context,"No Internet", "Please check yout internet Connection");

              }
            });
          } else {
            Constant().showDialogBox(context,"Unable to Proceed", "Please Enter All Field Correctly");
          }
        },
        padding: EdgeInsets.all(12),
        color: Constant.ButtonColor,
        child: Text(
            'Log In', style: TextStyle(color: Colors.white, fontSize: 16.0)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constant.AppColor,
        title: Text(Constant.name),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
            left: 24.0, right: 24.0, top: 24.0, bottom: 0.0),
        children: <Widget>[
          logo,
          SizedBox(height: 48.0),
          email,
          SizedBox(height: 16.0),
          password,
          SizedBox(height: 16.0),
          loginButton,
          // forgotLabel
        ],
      ),
    );
  }

}


