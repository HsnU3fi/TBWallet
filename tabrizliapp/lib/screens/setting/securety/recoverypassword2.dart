import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';

class RecaveryPassword2 extends StatefulWidget {
  final String DataToken2;

  RecaveryPassword2({
    Key key,
    @required this.DataToken2,
  }) : super(key: key);

  @override
  _RecaveryPassword2State createState() => _RecaveryPassword2State();
}

class _RecaveryPassword2State extends State<RecaveryPassword2> {
  @override
  String codeotp;
  String newpass;
  String repetpass;
  String cardtoken;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(252, 246, 225, 10),
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(10, 0, 0,0),
          icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.black),
          onPressed:()=> Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              icon: Icon(Icons.home, size: 30, color: Colors.black),
              onPressed: _home),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(252, 246, 225, 10),
        child: Center(
          child: ListView(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text("Tabrizli",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color.fromRGBO(140, 83, 62, 10),
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                  child: Text("امنیت و حریم خصوصی",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ]),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Text(
                          "رمز حساب تبریزلی",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                        child: Image.asset(
                          'assets/images/secure.png',
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "- - - - - - - - - - - - - - - - - - - - - - - - - - - ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 227, 166, 10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                      ),
                      // padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      height: 500,
                      width: 320,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                              child: Text(
                                "کد 6 رقمی پیامک شده",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                            child: TextField(
                              onChanged: (value) {
                                codeotp = value;
                              },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(250, 236, 196, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                hintText: "*******",
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                              child: Text(
                                "رمز جدید",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                            child: TextField(
                              onChanged: (value) {
                                newpass = value;
                              },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(250, 236, 196, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                hintText: "*******",
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                              child: Text(
                                "تکرار رمز",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                            child: TextField(
                              onChanged: (value) {
                                repetpass = value;
                              },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(250, 236, 196, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                hintText: "*******",
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: InkWell(
                        onTap: recovery,
                        child: Image.asset(
                          "assets/images/success.png",
                          height: 50,
                          width: 50,
                        ),
                      )),
                  Center(
                    child: Text(
                      "تایید",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _home() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void _showSnackBarWait() {
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
      content: Text('خطا',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSnackBar(BuildContext context) {
    Navigator.pop(context, false);
    final snackBar = SnackBar(
      content: Text('.با موفقیت انجام شد',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void recovery() async {
    if (widget.DataToken2 == null) {
      this._showSnackBarWait();
      final getDataUser = await User_Id();
      final decode = jsonDecode(getDataUser);
      final userId = decode['user_id'];
      var headers = await Headers();
      final prefs = await SharedPreferences.getInstance();
      final card = prefs.getString('getcard');
      var decode1 = jsonDecode(card);
      var decode2 = jsonDecode(decode1);
      for (var a in decode2) {
        setState(() {
          if (a["club_id"] == null && a["bank_code"] == 69) {
            cardtoken = a['token'];
          }
        });
      }
      Map data = {
        'OTP': codeotp,
        'accout_id': userId,
        'card_token': cardtoken,
        'new_password': newpass,
      };

      String body = json.encode(data);
      http
          .put(
              Apis().baseUrl +
                  'credit/v3/password/${cardtoken}/accounts/${userId}',
              body: body,
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 204) {
          this._showSnackBar(context);
        }else{
          Navigator.pop(context, false);
          this._showSnackBarErorr(context);
        }
      }).catchError((e) => {
        Navigator.pop(context, false),
        this._showSnackBarErorr(context)
      });
    }
    if (widget.DataToken2 != null) {
      var headers = await Headers();
      this._showSnackBarWait();
      final DataToken2 = widget.DataToken2;
      final decode = json.decode(DataToken2);
      final userid = decode['merchantId'];
      setState(() {
        cardtoken = decode['DataToken'][0]['token'];
      });

      Map data = {
        'OTP': codeotp,
        'accout_id': userid,
        'card_token': cardtoken,
        'new_password': newpass,
      };

      String body = json.encode(data);
      http
          .put(
              Apis().baseUrl +
                  'credit/v3/password/${cardtoken}/accounts/${userid}',
              body: body,
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 204) {
          this._showSnackBar(context);
        }else{
          Navigator.pop(context, false);
        this._showSnackBarErorr(context);
        }
      }).catchError((e) => {
        Navigator.pop(context, false),
        this._showSnackBarErorr(context)
      });
    }
  }
}
