import 'package:flutter/material.dart';
import 'package:tabrizli/screens/home/home.dart';

class VersionApp extends StatefulWidget {
  @override
  _VersionAppState createState() => _VersionAppState();
}

class _VersionAppState extends State<VersionApp> {
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
                  child: Text("نسخه برنامه",
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
                          "نسخه برنامه",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                        child: Image.asset(
                          'assets/images/versionapp.png',
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
                          Center(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                              child: Image.asset(
                                'assets/images/iconverssion.png',
                                height: 100,
                              ),
                            ),
                          ),
                          Container(
                              child: Text(
                            "Tabrizli",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          )),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                "1.0.0",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                "در حال حاضر نسخه برنامه شما بروز می باشد",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ))
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

// void _Scuerty() {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => Securety()));
// }
}
