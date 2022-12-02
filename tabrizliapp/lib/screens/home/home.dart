import 'dart:convert';

// import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:device_info_plus/device_info_plus.dart';

import 'package:http/http.dart' as http;
// import 'package:package_info/package_info.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/maps/maps.dart';
import 'package:tabrizli/screens/merchants/merchants.dart';
import 'package:tabrizli/screens/scan/scan.dart';
import 'package:tabrizli/screens/setting/setting.dart';
import 'package:tabrizli/screens/ticket/ticket.dart';
import 'package:tabrizli/screens/users/editUsers.dart';
import 'package:tabrizli/screens/wallet/wallet.dart';
import '../municipality/Municipality.dart';
import '../bank/bank.dart';
import '../buy/buy.dart';
import '../manymedia/manymedia.dart';
import '../othersService/othersService.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _publickey();
    _getaccount();
    _version();
    _getcard();
  }

  String name = '';
  int balance = 0;
  bool is_merchants = false;
  String profile_picture;
  bool isbalance = true;
  bool isProfilePicture = false;
  bool isProfilePictureUrl = false;
  bool defualtbalance = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(252, 246, 225, 10),
        title: Row(
          children: [
            //   felan in ghesmat camment beshe bad check konam

            // if (isProfilePictureUrl)
            //   InkWell(
            //     onTap: _edit,
            //     child: SizedBox(
            //         height: 50,
            //         width: 50,
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(50)),
            //               image: DecorationImage(
            //                 image: NetworkImage('$profile_picture'),
            //                 fit: BoxFit.fill,
            //               )),
            //         )),
            //   ),
            // if (isProfilePicture)
              InkWell(
                onTap: _edit,
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          image: DecorationImage(
                            image: ExactAssetImage(
                                "assets/images/default-profile-picture.jpg"),
                            fit: BoxFit.fill,
                          )),
                    )),
              ),

            InkWell(
              onTap: _edit,
              child: Container(
                child: Text(
                  '$name',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              icon: Icon(Icons.settings,
                  size: 30, color: Color.fromRGBO(140, 83, 62, 10)),
              onPressed: _setting),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(252, 246, 225, 10),
        child: Center(
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                child: FittedBox(
                  // fit: BoxFit.fill,
                  child: Image.asset('assets/images/imagehome.png'),
                ),
                height: 150,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 155,
                          width: 150,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            onPressed: _wallet,
                            child: Stack(
                              children: [
                                Image.asset(
                                    'assets/images/InventoryWallet.png'),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 30, 20, 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('موجودی',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                      if (defualtbalance)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text('$balance',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center),
                                          ],
                                        ),
                                      if (isbalance)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: CircularProgressIndicator(
                                                  valueColor:
                                                      new AlwaysStoppedAnimation<
                                                          Color>(Colors.white)),
                                              height: 20,
                                              width: 20,
                                            )
                                          ],
                                        ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('ریال',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "کیف پول",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: SizedBox(
                            height: 155,
                            width: 80,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(color: Colors.black)),
                                color: Color.fromRGBO(250, 236, 196, 10),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Image.asset(
                                    'assets/images/shahrdarisakhteman.png'),
                                onPressed: _municipality),
                          ),
                        ),
                        Center(
                          child: Text(
                            "شهرداری",
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
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                height: 70,
                                width: 70,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        side: BorderSide(color: Colors.black)),
                                    color: Color.fromRGBO(250, 236, 196, 10),
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child:
                                        Image.asset('assets/images/scan.png'),
                                    onPressed: _Scan),
                              ),
                            ),
                            Center(
                              child: Text(
                                "اسکن",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        if(true)
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                height: 70,
                                width: 70,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        side: BorderSide(color: Colors.black)),
                                    color: Color.fromRGBO(250, 236, 196, 10),
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child:
                                        Image.asset('assets/images/bank.png'),
                                    onPressed: () {
                                      _showSnackBar(context);
                                    }),
                              ),
                            ),
                            Center(
                              child: Text(
                                "بانک",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Image.asset('assets/images/bime.png'),
                              onPressed: () {
                                _showSnackBar(context);
                              }),
                        ),
                      ),
                      Center(
                        child: Text(
                          "بیمه",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Image.asset('assets/images/buy.png'),
                              onPressed: () {
                                _buy();
                              }),
                        ),
                      ),
                      Center(
                        child: Text(
                          "خرید و خدمات",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: SizedBox(
                          height: 70,
                          width: 160,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Image.asset('assets/images/ticket.png'),
                              onPressed: () {
                                _ticket();
                              }),
                        ),
                      ),
                      Center(
                        child: Text(
                          "بلیط و گردشگری",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
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
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Image.asset(
                                'assets/images/learn.png',
                                height: 50,
                                width: 50,
                              ),
                              onPressed: () {
                                _showSnackBar(context);
                              }),
                        ),
                      ),
                      Center(
                        child: Text(
                          "آموزش و فرهنگ",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Image.asset(
                                'assets/images/manymedia.png',
                                height: 50,
                                width: 50,
                              ),
                              onPressed: () {
                                _manyMedia();
                              }),
                        ),
                      ),
                      Center(
                        child: Text(
                          "چند رسانه‌ای",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Image.asset(
                                'assets/images/other.png',
                                height: 50,
                                width: 50,
                              ),
                              onPressed: () {
                                _othersService();
                              }),
                        ),
                      ),
                      Center(
                        child: Text(
                          "سایر سرویس ها",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/map.png'),
                            onPressed: () {
                              _maps();
                            },
                          ),
                        ),
                      ),
                      Center(
                        // padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: Text(
                          "نقشه ها",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _wallet() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Wallet();
    }));
  }

  void _Scan() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scan();
    }));
  }

  void _setting() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Setting();
    }));
  }

  void _merchants() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Merchants();
    }));
  }

  void _municipality() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Municipality();
    }));
  }

  void _buy() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Buy();
    }));
  }

  void _manyMedia() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Manymedia();
    }));
  }

  void _ticket() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Ticket();
    }));
  }

  void _othersService() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OthersService();
    }));
  }

  void _bank() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Bank();
    }));
  }

  void _edit() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditUsers();
    }));
  }
  void _maps() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IframeDemo();
    }));
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

  _version() async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String version = packageInfo.version;
    if (kIsWeb) {
      // if (Platform.isAndroid) {
      var deviceInfo = await DeviceInfoPlugin();
      // var release = androidInfo;
      var Info = await deviceInfo.webBrowserInfo;
      var release = Info.appVersion;
      var model = Info.product;

      var os = Info.platform;
      print(os);

      Map data = {
        "os": os,
        "appid": Apis().appId,
        "device_model": model,
        "app_version": "1.0.0+1",
        "os_version": release,
        "locality": "fa"
      };
      var headers = await Headers();
      String body = jsonEncode(data);
      http
          .post(Apis().baseUrl + 'application/v3/version',
              body: body, headers: headers)
          .then((resp) {
        if (resp.statusCode == 200) {
          print(resp.body);
        }
      });
      // }
    }
  }

  void _getcard() async {
    var headers = await Headers();
    await http
        .get(Apis().baseUrl + 'payment/v3/cards?cashout=false&club=true',
            headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var data = resp.body;
        SharedPrefi().save('getcard', data);
        var decode = jsonDecode(data);
        for (var a in decode) {
          setState(() {
            if (a["club_id"] == null && a["bank_code"] == 69) {
              balance = a['balance'];
              if (balance != null) {
                setState(() {
                  isbalance = false;
                  defualtbalance = true;
                });
              }
            }
          });
        }
      }
    });
  }

  void _getaccount() async {
    final getDataUser = await User_Id();
    final decode = jsonDecode(getDataUser);
    final userId = decode['user_id'];
    var headers = await Headers();
    await http
        .get(Apis().baseUrl + 'users/v3/accounts/$userId?mod=1',
            headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var data = resp.body;
        var decode = jsonDecode(data);
        setState(() {
          name = decode['name'];
          if (name == null || name == '') {
            setState(() {
              name = decode['mobile_phone'];
            });
          }
          if (decode['profile_picture'] != "") {
            setState(() {
              isProfilePictureUrl = true;
            });
            profile_picture =
                'https://api.paygear.ir/files/v3/${decode['profile_picture']}?cache-first';
          } else {
            setState(() {
              isProfilePicture = true;
            });
          }
        });
      }
    });
  }

  void _publickey() async {
    var headers = await Headers();
    await http
        .get(Apis().baseUrl + 'payment/v3/key', headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var data = resp.body;
        var decode = jsonDecode(data);
        var publickey = decode['key'];
      }
    });
  }
}
