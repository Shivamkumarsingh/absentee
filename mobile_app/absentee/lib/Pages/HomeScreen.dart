import 'package:absentee/Utils/Constant.dart';
import 'package:absentee/Utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:absentee/Utils/SharedPreferencesHelper.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:absentee/Models/UserModel.dart';
import 'package:absentee/Utils/Connectivity.dart';
import 'package:absentee/Models/SensorModel.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  NetworkCheck networkCheck = NetworkCheck();
  List<Sensor> sensorlist = List();
  String userName;
  String userEmail;
  List<Class> classList = List();
  var isLoading = false;
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Future getClassDataFromServer() async {
     setState(() {
        isLoading = true;
      });

      // Await the http get response, then decode the json-formatted responce.

    await http.get(Constant.classListAPI, headers: requestHeaders)
        .then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse != null) {
            classList =(jsonResponse as List).map((data) => new Class.fromJson(data)).toList();
            if (classList.length <= 0){
              Constant().showDialogBox(context,"Error", "Sensors data not found");
            }
            setState(() {
              isLoading = false;
            });
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
          Constant().showDialogBox(context,"Log in Failed", "Error : ${itemCount}");
        }
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        Constant().showDialogBox(context,"Process Failed", "Error : $error");
      });

  }
  Future getSensorDataFromServer(int index) async {
    if (classList.length > index) {
      // Await the http get response, then decode the json-formatted responce.
      await http.get('${Constant.attendanceListAPI}/${classList[index].id}/todays_attendance', headers:requestHeaders ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          var data = jsonResponse['data'];
          var cumulative_data = data['cumulative_data'];

          if (cumulative_data != null) {
            sensorlist =(cumulative_data as List).map((data) => new Sensor.fromJson(data)).toList();
            if (sensorlist.length <= 0){
              Constant().showDialogBox(context,"Error", "Sensors data not found");
            }
            setState(() {
              isLoading = false;
            });
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
          Constant().showDialogBox(context,"Log in Failed", "Error : ${itemCount}");
        }
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        Constant().showDialogBox(context,"Process Failed", "Error : $error");
      });
    }else{
      Constant().showDialogBox(context,"Process Failed", "Unable to fetch site data");
    }
  }

  Future getUserDetails() async {
    userName = await SharedPreferencesHelper.getUser();
    userEmail = await SharedPreferencesHelper.getEmail();
    setState(() {});
  }
    @override
  void initState() {
    super.initState();
    getUserDetails();
    networkCheck.checkInternet((isNetworkPresent){
          if(isNetworkPresent) {
            getClassDataFromServer();
          //  getSensorDataFromServer(0);
          }else{
            Constant().showDialogBox(context,"No Internet", "Please check yout internet Connection");

          }
        });
  }
  @override
  void dispose() {
    super.dispose();
  }

  bool isStatusCritical(String status) {
    if (status == "critical") {
      return true;
    }
    return false;
  }

  List<Widget> _buildUserGroups(BuildContext context) {
    var userGroup = List<Widget>();

    for (var i = 0; i < classList.length; i++) {
      userGroup.add(new ListTile(
        dense: true,
        leading: Icon(
          Icons.star,
          color: Constant.ButtonColor,
          size: 28,
        ),
        title: Text('Class ${classList[i].title } - Div ${classList[i].name}',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        onTap: () {
          Navigator.of(context).pop();
          networkCheck.checkInternet((isNetworkPresent){
            if(isNetworkPresent) {
              getSensorDataFromServer(i);
            }else{
              Constant().showDialogBox(context,"No Internet","Please check yout internet Connection");

            }
          });

        },
      ));
      userGroup.add(new Divider(
        color: Colors.black38,
        indent: 16.0,
      ));
    }
    setState(() {});
    return userGroup;
  }

  @override
  Widget build(BuildContext context) {
    final logoutButton = FlatButton(

      child: Text(
        'Logout',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        textAlign: TextAlign.right,
      ),
      onPressed: () {
        MyNavigator.asyncConfirmDialog(context, 'Logout', "   Do you want to logout?");
      },
    );

    return  WillPopScope(
      onWillPop: (){
        MyNavigator.asyncConfirmDialog(context, 'Exit', "   Do you want to exit?");
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constant.AppColor,
            title: Text(Constant.name),
            actions: <Widget>[
              Padding(
                child: logoutButton,
                padding: const EdgeInsets.only(right: 0.0),
              )
            ],
          ),
          drawer: Drawer(
            child: ListView(children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  userName ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text(
                  userEmail ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(color: Constant.AppColor),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/images/man.png", fit: BoxFit.fitHeight, height: 48.0, width: 48.0),
                ),
              ),
              new Column(
                children: _buildUserGroups(context),
              )
            ], padding: EdgeInsets.all(0)),
          ),
          backgroundColor: Colors.white70,
          body: isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
              itemCount: sensorlist.length,
              itemBuilder: (context, index) {
                return new Card(
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(left: 12),
                                  child: Image.asset(
                                      isStatusCritical(sensorlist[index].status)
                                          ? "assets/images/cancel.png"
                                          : "assets/images/checked.png",
                                      fit: BoxFit.scaleDown,
                                      height: 24.0,
                                      width: 24.0)),
                              Padding(padding: EdgeInsets.only(bottom: 56))
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                          ),

                          Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      '${sensorlist[index].sensor_name}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Reading: ${sensorlist[index].current_readings}',
                                        style:
                                        TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8, bottom: 12),
                                      child: Text(
                                        'At: ${sensorlist[index].last_reading_at}',
                                        style:
                                        TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                              Padding(
                                  padding: EdgeInsets.only(right: 12),
                                child:
                                OutlineButton(
                                    child: const Text('Readings',style: TextStyle(color: Constant.ButtonColor, fontSize: 16)),
                                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(18.0)),color:Constant.ButtonColor,
                                     onPressed: () {

                                     },
                                  padding: EdgeInsets.only(right: 18,left: 18),
                                  disabledBorderColor: Constant.ButtonColor,
                                  borderSide: BorderSide(color: Constant.ButtonColor, width: 2, style: BorderStyle.solid),
                                )
                              )
                        ]));
              })
      )
    );
  }
}
