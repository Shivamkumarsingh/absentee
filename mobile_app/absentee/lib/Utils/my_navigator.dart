import 'package:flutter/material.dart';
import 'package:absentee/Utils/SharedPreferencesHelper.dart';
import 'package:absentee/Utils/Constant.dart';
import 'package:flutter/services.dart';
class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  static void goToSignIn(BuildContext context) {
    Navigator.pushNamed(context, "/signin");
  }

  static void goToSignInAfterSignOut(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/signin', (Route<dynamic> route) => false);
  }

  static Future<bool> asyncConfirmDialog(BuildContext context,String Title, String SubTitle) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18.0))),
         //contentPadding: EdgeInsets.only(top: 10.0),
          elevation: 12.0,
          title: Column(children: <Widget>[Icon(Icons.error_outline,size:40,color: Colors.red,),Text(Title)],),
          content: Padding(padding: EdgeInsets.all(16),child:Center(heightFactor: .5,child:Text(SubTitle),) ,),
          contentPadding: EdgeInsets.all(8),
          actions: <Widget>[
            Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 16)),
                OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('CANCEL', style: TextStyle(color: Colors.black38, fontSize: 12.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    return false;
                  },
                  padding: EdgeInsets.only(left: 30,right: 30,top: 12,bottom: 12),
                  color: Colors.white,
                  disabledBorderColor: Colors.black38,
                  borderSide: BorderSide(color: Colors.black38, width: 2, style: BorderStyle.solid),
                ),

                Padding(padding: EdgeInsets.only(right: 40)),

                OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    if (Title == "Logout"){
                      Navigator.of(context).pop();
                      SharedPreferencesHelper.removeUser();
                      MyNavigator.goToSignInAfterSignOut(context);
                    }else if (Title == "Exit"){
                      SystemNavigator.pop();
                    }
                    return true;
                  },
                  padding: EdgeInsets.only(left: 40,right: 40,top: 12,bottom: 12),
                  color: Colors.white,
                  child: Text('YES', style: TextStyle(color: Constant.ButtonColor, fontSize: 12.0)),
                  disabledBorderColor: Constant.ButtonColor,
                  borderSide: BorderSide(color: Constant.ButtonColor, width: 2, style: BorderStyle.solid),
                ),

                Padding(padding: EdgeInsets.only(right: 16)),
              ],
            )


          ],
        );
      },
    );
  }
}
