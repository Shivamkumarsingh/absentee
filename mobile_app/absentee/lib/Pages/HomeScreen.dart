import 'package:absentee/Utils/Constant.dart';
import 'package:absentee/Utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:absentee/Utils/SharedPreferencesHelper.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:absentee/Utils/Connectivity.dart';
import 'package:absentee/Models/SensorModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  NetworkCheck networkCheck = NetworkCheck();
  List<Attendance> sensorlist = List();
  String userName;
  String userEmail;
  int selectedClass = 0;
  List<Class> classList = List();
  var isLoading = false;
  Future sendAttendance() async {
    setState(() {
      isLoading = true;
    });
    List <int> absentList = List<int>() ;
      for (int i = 0 ;i< sensorlist.length;i++){
        if (sensorlist[i].present == false){
          absentList.add(sensorlist[i].roll_number);
        }
      }
    // Await the http get response, then decode the json-formatted response.
    await http.post('${Constant.attendanceListAPI}/${classList[selectedClass].id}/attendances',
        body:json.encode({'attendance':absentList}), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': await  SharedPreferencesHelper.getAuth_Token()
    }).then((http.Response response){
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        var jsonResponse = jsonDecode(response.body);
        var message = jsonResponse['message'];
        if(message != null){
          Constant().showDialogBox(context,"Success!", "$message");
        }else{
          var message = jsonResponse['message'];
          Constant().showDialogBox(context,"Failed!", "$message");

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
    }).catchError((error){
      setState(() {
        isLoading = false;
      });
      Constant().showDialogBox(context,"Log in Failed", "Error : $error");

    });

  }
  Future getClassDataFromServer() async {
     setState(() {
        isLoading = true;
      });

      // Await the http get response, then decode the json-formatted responce.
    await http.get(Constant.classListAPI, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': await  SharedPreferencesHelper.getAuth_Token()
    }) .then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse != null) {
            classList =(jsonResponse as List).map((data) => new Class.fromJson(data)).toList();
            if (classList.length > 0){
              getAttendanceFromServer(selectedClass);
            }else{
              Constant().showDialogBox(context,"Error", "Class data not found");
            }
            setState(() {
              isLoading = false;

            });
          }
        } else if(response.statusCode == 401){
          MyNavigator.asyncConfirmDialog(context, 'Logout', "Session Expired,Please Log out");
        }else {
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
  Future getAttendanceFromServer(int index) async {
    if (classList.length > index) {
      // Await the http get response, then decode the json-formatted responce.
      await http.get('${Constant.attendanceListAPI}/${classList[index].id}/todays_attendance', headers:{
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': await  SharedPreferencesHelper.getAuth_Token()
      } ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse != null) {
            sensorlist =(jsonResponse as List).map((data) => new Attendance.fromJson(data)).toList();
            if (sensorlist.length <= 0){
              Constant().showDialogBox(context,"Error", "Attendance data not found");
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
      Constant().showDialogBox(context,"Process Failed", "Unable to fetch Class data");
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
          }else{
            Constant().showDialogBox(context,"No Internet", "Please check yout internet Connection");

          }
        });
  }
  @override
  void dispose() {
    super.dispose();
  }

  bool isStudentPresent(bool status) {
    if (status == null || status == null) {
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
              selectedClass = i;
              getAttendanceFromServer(selectedClass);

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
    final sumitButton = FlatButton(

      child: Text(
        'Submit',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        textAlign: TextAlign.right,
      ),
      onPressed: () {
        sendAttendance();
      },
    );

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
            title: Text('Class ${classList[selectedClass].title } - Div ${classList[selectedClass].name} ?? Absentee',
            actions: <Widget>[
              Padding(
                child: sumitButton,
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
                accountEmail:logoutButton,
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
                          Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      '${sensorlist[index].name}',
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
                                        'Roll No: ${sensorlist[index].roll_number}',
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
                                Checkbox(value:isStudentPresent(sensorlist[index].present), onChanged: (value){
                                  setState(() {
                                      sensorlist[index].present = value;

                                  });
                                } )
                              )
                        ]));
              })
      )
    );
  }
}
