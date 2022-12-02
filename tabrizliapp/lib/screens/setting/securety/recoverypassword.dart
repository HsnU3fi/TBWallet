import 'dart:convert';

// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:http/http.dart' as http;
import 'package:tabrizli/screens/setting/securety/recoverypassword2.dart';
import '../setting.dart';

class RecaveryPassword extends StatefulWidget {
  final String DataToken;

  RecaveryPassword({Key key, @required this.DataToken}) : super(key: key);

  @override
  _RecaveryPasswordState createState() => _RecaveryPasswordState();
}

class _RecaveryPasswordState extends State<RecaveryPassword> {
  @override
  String cardtoken;
  String DataToken2;
  String textMassage="شما درخواست بازیابی رمز داده اید. پس از تایید پیامکی شامل یک کد 6 رقمی برای شما ارسال خواهد شد. از این کد برای تغییر رمز استفاده کنید";


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
                          "درخواست بازیابی رمز",
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
                      height: 350,
                      width: 320,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                              child: Text(
                                "شما درخواست بازیابی رمز داده اید.  پس از تایید پیامکی شامل یک کد 6 رقمی برای شما ارسال خواهد شد",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 1, 20, 0),
                              child: Text(
                                ".از این کد برای تغییر رمز استفاده کنید",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ))
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: InkWell(
                              onTap: _setting,
                              child: Image.asset(
                                "assets/images/cansel.png",
                                height: 50,
                                width: 50,
                              ),
                            )),
                        Center(
                          child: Text(
                            "انصراف",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(100, 50, 0, 0),
                            child: InkWell(
                              onTap: _Opt,
                              child: Image.asset(
                                "assets/images/success.png",
                                height: 50,
                                width: 50,
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                          child: Text(
                            "تایید",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _home() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void _Opt() async {
    if (widget.DataToken == null) {
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
      final getDataUser = await User_Id();
      final decode = jsonDecode(getDataUser);
      final userId = decode['user_id'];
      var headers = await Headers();
      await http
          .get(
              Apis().baseUrl +
                  'credit/v3/password/${cardtoken}/accounts/${userId}',
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 204) {
          this._recovery2();
        }else{
          Navigator.pop(context, false);
        this._showSnackBarErorr(context);
        }
      }).catchError((e) => {
        Navigator.pop(context, false),
        this._showSnackBarErorr(context)
      });
    }

    if (widget.DataToken != null) {
      setState(() {
        DataToken2 = widget.DataToken;
        print("DataToken2");
        print(DataToken2);
        print(DataToken2.runtimeType);
      });
      final DataToken = widget.DataToken;
      final decode = json.decode(DataToken);
      final userid = decode['merchantId'];
      setState(() {
        cardtoken = decode['DataToken'][0]['token'];
      });
      var headers = await Headers();
      await http
          .get(
              Apis().baseUrl +
                  'credit/v3/password/${cardtoken}/accounts/${userid}',
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 204) {
          this._sendDataToRecaveryPassword2(context);
        }
      });
    }
  }

  void _setting() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Setting();
    }));
  }

  void _sendDataToRecaveryPassword2(BuildContext context) {
    print("manam manam");

    print(DataToken2);

    String textToSend = DataToken2;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecaveryPassword2(
            DataToken2: textToSend,
          ),
        ));
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

  void _recovery2() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RecaveryPassword2();
    }));
  }
}
