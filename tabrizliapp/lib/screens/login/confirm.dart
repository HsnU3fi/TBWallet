import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/login/splashScreen.dart';
import 'package:tabrizli/screens/users/users.dart';
import '../home/home.dart';

class Confirm extends StatefulWidget {
  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  String otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(252, 246, 225, 10),
        child: Center(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 200, 20, 0),
                      child: Text(
                        ".کد فعال سازی خود را وارد کنید",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: TextField(
                  onChanged: (value) {
                    otp = value;
                  },
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(250, 236, 196, 10),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: "کد فعال سازی ۴رقمی",
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: RaisedButton(
                  onPressed: _confirm,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)),
                  textColor: Colors.white,
                  color: Colors.green,
                  splashColor: Colors.black,
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    "تایید",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _confirm() async {
    if (otp != null && otp.length == 4) {
      this._loader();

      final prefs = await SharedPreferences.getInstance();
      final mobile_phone = prefs.getString('phone');
      Map data = {
        'phone': mobile_phone,
        'app_id': Apis().appId,
        'otp': otp,
        "pushappid": Apis().appId,
      };
      String body = json.encode(data);
      http.post(Apis().baseUrl + 'users/v3/auth/otp/verify',
          body: body,
          headers: {
            'Content-Type': 'application/json; charset=utf-8'
          }).then((resp) {
        if (resp.statusCode == 200) {
          SharedPrefi().save('data', resp.body);
          SharedPrefi().save('datatoken', resp.headers);
          var decode = jsonDecode(resp.body);
          var is_new = decode['is_new'];

          if (is_new == true) {
            Navigator.pop(context, false);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Users();
            }));
          }
          if (is_new == false) {
            Navigator.pop(context, false);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return SplashScreen();
            }));
          }
        } else {
          this._showSnackBarErorr(context);
        }
      });
    } else {
      this._showSnackBarErorr(context);
    }
  }

  void _loader() {

    AwesomeDialog(
        dismissOnBackKeyPress: false,
        dialogType: DialogType.NO_HEADER,
        context: context,
        body: Container(
          height: 80,
          // color: Color.fromRGBO(252, 246, 225, 10),
          child: Column(
            children: [
              CircularProgressIndicator(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      ".لطفا منتظر بمانید",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ))
      ..show();
  }

  void _showSnackBarErorr(BuildContext context) {
    Navigator.pop(context,false);
    final snackBar = SnackBar(
      content: Text('.کد وارد شده صحیح نمی باشد',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
