import 'dart:async';
import 'package:http/http.dart' as http;

Future <http.Response>getSignInResponse(String usernameText, String passwordText) async {
  var url = "http://api.simplysmart.tech/api/sessions/sign_in";
  Map map = {
    'session[login]': usernameText,
    'session[password]': passwordText,
    'session[device_id]': 'Mobile',
    'third_party_apps': 'acufire',
    'user_login': 'true'
  };
  print(map);
  // Await the http get response, then decode the json-formatted response.
  await http.post(url, body: map, headers: {
    'Accept': 'application/vnd.simplysmart.v1+json',
    'Content-Type': 'application/x-www-form-urlencoded'
  }).then((http.Response response){
    return response;

  }).catchError((error){
    return error;
  });
}