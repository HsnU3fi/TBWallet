import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/config/config.dart';
import 'confirm.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  String mobile_phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(252, 246, 225, 10),
        child: Center(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: Image.asset(
                  'assets/images/logotabrizli.png',
                  height: 200,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                      child: Text(
                        ".شماره موبایل خود را وارد کنید",
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
                    mobile_phone = value;
                  },
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(250, 236, 196, 10),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: "شماره موبایل",
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: RaisedButton(
                  onPressed: _login,
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

  _login() async {
    // this._showSnackBar(context);
    print("help");
    if (mobile_phone != null &&
        mobile_phone.length == 11 &&
        mobile_phone.substring(0, 2) == "09") {
      this._loader();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('phone', mobile_phone);
      prefs.getString('phone');
      Map data = {'phone': mobile_phone, 'app_id': Apis().appId};
      String body = json.encode(data);
      http.post(Apis().baseUrl + 'users/v3/auth/otp', body: body, headers: {
        'Content-Type': 'application/json; charset=utf-8'
      }).then((resp) {
        if (resp.statusCode == 204) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Confirm();
          }));
        }
      }).catchError((e) => {
        Navigator.pop(context,false),
        this._showSnackBarErorrApi(context)});
    } else {
      this._showSnackBarErorr(context);
    }
  }

  void _loader() {
    // Navigator.pop(context, false);
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
    final snackBar = SnackBar(
      content: Text('.شماره موبایل معتبر نیست',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSnackBarErorrApi(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('خطا',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
