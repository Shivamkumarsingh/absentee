import 'package:flutter/material.dart';

class Constant {
  static const String name = "Absentee";
  static const Color AppColor = Color(0xFF333745);
  static const Color ButtonColor = Colors.red;
  static const String baseURL = "http://api.simplysmart.tech";
  static const String baseURLString = "api.simplysmart.tech";
  static const String signInAPI = baseURL + "/api/sessions/sign_in";
  static const String senesorListAPI = "/api/admin/sensors";
  static const String sensorReadingAPI = '/api/sensor_readings';

  void showDialogBox(BuildContext context, String Title, String SubTitle) {
    showDialog(
        context: context,
        barrierDismissible: true,

        builder: (_) =>
            AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18.0))),
              elevation: 12.0,
              title: Icon(Icons.error_outline,size:40,color: Colors.red,),
              contentPadding: EdgeInsets.all(8),
              content: Container(
                width: 260.0,
                height: 200.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // dialog top
                     Text(Title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    // dialog centre
                    new Expanded(
                      child: new Container(
                          padding: EdgeInsets.all(16),
                          child: Center(heightFactor: .1,child:Text(SubTitle,)
                          )
                      ),
                      flex: 2
                    ),
                    // dialog bottom
                     Container(
                        padding: new EdgeInsets.all(16.0),
                        child: OutlineButton(
                          child: const Text('OK',style: TextStyle(color: Constant.ButtonColor, fontSize: 16)),
                          shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(18.0)),color:Constant.ButtonColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.only(right: 18,left: 18),
                          disabledBorderColor: Constant.ButtonColor,
                          borderSide: BorderSide(color: Constant.ButtonColor, width: 2, style: BorderStyle.solid),
                        ),
                      ),

                  ],
                ),
              ),
            ));
  }
}