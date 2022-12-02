import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/login/login.dart';
import 'package:tabrizli/screens/setting/securety/securety.dart';
import 'package:tabrizli/screens/setting/versionapp.dart';
import 'dart:js' as js;

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
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
                  child: Text("تنظیمات",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ]),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Text(
                            "امنیت و حریم خصوصی",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: _Scuerty,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
                        child: Image.asset(
                          'assets/images/secure.png',
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          "- - - - - - - - - - - - - - - - - - - - - - - - - - - ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Text(
                            "نسخه برنامه",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: _VersionApp,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
                        child: Image.asset(
                          'assets/images/versionapp.png',
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          "- - - - - - - - - - - - - - - - - - - - - - - - - - - ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Text(
                            "درباره برنامه",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          js.context.callMethod(
                              'open', ['http://tabrizliapp.com/about.html']);
                        },
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
                        child: Image.asset(
                          'assets/images/infoapp.png',
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          "- - - - - - - - - - - - - - - - - - - - - - - - - - -  ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Text(
                            "قوانین و مقررات",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          js.context.callMethod(
                              'open', ['http://tabrizliapp.com/policy.html']);
                        },
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
                        child: Image.asset(
                          'assets/images/law.png',
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          "- - - - - - - - - - - - - - - - - - - - - - - - - - - ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Text(
                            "تماس با ما",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          js.context.callMethod(
                              'open', ['http://tabrizliapp.com/contact.html']);
                        },
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
                        child: Image.asset(
                          'assets/images/call.png',
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          "- - - - - - - - - - - - - - - - - - - - - - - - - - -  ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Text(
                            "سوالات متداول",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {},
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
                        child: Image.asset(
                          'assets/images/quiz.png',
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          "- - - - - - - - - - - - - - - - - - - - - - - - - - - ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Text(
                            "خروج از حساب کاربری",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: _Exit,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
                        child: Image.asset(
                          'assets/images/exit.png',
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          "- - - - - - - - - - - - - - - - - - - - - - - - - - -  ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
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

  void _VersionApp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => VersionApp()));
  }

  void _Scuerty() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Securety()));
  }

  void _Exit() async {
    SharedPrefi().remove('datatoken');
    SharedPrefi().remove('data');

    final prefs = await SharedPreferences.getInstance();
    final gettoken = prefs.getString('datatoken');

    if (gettoken == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
