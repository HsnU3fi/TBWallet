import 'package:flutter/material.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/municipality/amvat.dart';
import 'package:tabrizli/screens/municipality/pasmand.dart';
import 'package:tabrizli/screens/municipality/rahgiryShahrsazi.dart';
import 'package:tabrizli/screens/setting/setting.dart';
import 'dart:js' as js;
import 'avarezDaramad.dart';
import 'avarezNosazi.dart';
import 'avarezTabloSenfi.dart';
import 'avarzSenfi.dart';
import 'monaghesat.dart';

class Municipality extends StatefulWidget {
  @override
  _MunicipalityState createState() => _MunicipalityState();
}

class _MunicipalityState extends State<Municipality> {
  // WebController webController;

  void _setting() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Setting();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(252, 246, 225, 10),
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            icon: Icon(Icons.home, size: 30, color: Colors.black),
            onPressed: () {
              _home();
            },
          ),
          //     IconButton(
          //         padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          //         icon: Icon(Icons.settings,
          //             size: 30, color: Color.fromRGBO(140, 83, 62, 10)),
          //         onPressed: _setting),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(252, 246, 225, 10),
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
                child: Text("شهرداری",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ]),
            Container(
              child: FittedBox(
                child: Image.asset('assets/images/imagehome.png'),
              ),
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/motavafi.png'),
                            onPressed: () {
                              js.context.callMethod(
                                  'open', ['http://185.178.220.91/amvat']);
                            }),
                      ),
                    ),
                    Center(
                      child: Text(
                        "جستجوی متوفی",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/shahrsazi.png'),
                            onPressed: () {
                              js.context.callMethod(
                                  'open', ['http://185.178.220.91/shahrsazi']);
                            }),
                      ),
                    ),
                    Center(
                      child: Text(
                        "رهگیری شهرسازی",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/mozayede.png'),
                            onPressed: () {
                              js.context.callMethod(
                                  'open', ['https://monagesat.tabriz.ir/']);
                            }),
                      ),
                    ),
                    Center(
                      child: Text(
                        "مناقصات و مزایدات",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/khodro.png'),
                            onPressed: () {
                              js.context.callMethod(
                                  'open', ['https://citizen.tabriz.ir/home/Paycarbill']);
                            }),
                      ),
                    ),
                    Center(
                      child: Text(
                        "عوارض خودرو",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/nosazi.png'),
                            onPressed: () {
                              js.context.callMethod('open', [
                                'http://citizen.tabriz.ir/Home/PayCityBill?Param=1'
                              ]);
                            }),
                      ),
                    ),
                    Center(
                      child: Text(
                        "عوارض نوسازی",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/daramad.png'),
                            onPressed: () {
                              js.context.callMethod('open', [
                                'http://citizen.tabriz.ir/Home/PayCityBill?Param=2'
                              ]);
                            }),
                      ),
                    ),
                    Center(
                      child: Text(
                        "عوارض درآمد",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/senfi.png'),
                            onPressed: () {
                              js.context.callMethod('open', [
                                'http://citizen.tabriz.ir/Home/PayCityBill?Param=3'
                              ]);
                            }),
                      ),
                    ),
                    Center(
                      child: Text(
                        "عوارض صنفی",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/pasmand.png'),
                            onPressed: () {
                              js.context.callMethod('open', [
                                'http://citizen.tabriz.ir/Home/PayCityBill?Param=4'
                              ]);
                            }),
                      ),
                    ),
                    Center(
                      child: Text(
                        "عوارض پسماند",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/tablosenfi.png'),
                            onPressed: () {
                              js.context.callMethod('open',
                                  ['https://citizen.tabriz.ir/Home/PayPanel']);
                            }),
                      ),
                    ),
                    Center(
                      child: Text(
                        "عوارض تابلوهای صنفی",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('.این سرویس بزودی فعال می شود',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _passmand() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Passmand();
    }));
  }

  void _darmad() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AvarezDaramad();
    }));
  }

  void _rahgirySharsazi() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RahgirySharsazi();
    }));
  }

  void _amvat() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Amvat();
    }));
  }

  void _monaghesat() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Monaghesat();
    }));
  }

  void _avarezTabloSenfi() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AvarezTabloSenfi();
    }));
  }

  void _avarezSenfi() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AvarezSenfi();
    }));
  }

  void _avarezNosazi() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AvarezNosazi();
    }));
  }

  void _home() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }
}
