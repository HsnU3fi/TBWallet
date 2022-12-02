import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/bank/transferMoney.dart';
import 'package:tabrizli/screens/cardsme/cardsme.dart';
import 'package:tabrizli/screens/cashout/cashout.dart';
import 'package:tabrizli/screens/charge/charge.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/merchants/merchants.dart';
import 'package:tabrizli/screens/paymentOrders/orders.dart';
import 'package:http/http.dart' as http;
import 'package:tabrizli/screens/scan/scan.dart';
import 'package:tabrizli/screens/setting/securety/recoverypassword.dart';
import 'package:tabrizli/screens/setting/securety/setpassword.dart';

class Wallet extends StatefulWidget {
  final String merchantId;

  Wallet({Key key, @required this.merchantId}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  void _merchants() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Merchants();
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isMerchant();
    getAccount();
    _getcard();
  }

  bool is_merchants = false;
  bool changePass = false;
  bool justMerchant = false;
  bool chargeOff = false;
  bool isbalance = true;
  bool defualtbalance = false;
  String name = '';
  String SendData;
  String DataToken;
  String role;
  bool disbandCashOut = true;
  List getCard;
  int balance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(252, 246, 225, 10),
        title: Row(
          children: [
            SizedBox(
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
            Container(
              child: Text(
                '$name',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            ),
          ],
        ),
        actions: [
          if (is_merchants)
            IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                icon: Icon(Icons.add_business_sharp,
                    size: 30, color: Colors.black),
                onPressed: _merchants),
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              icon: Icon(Icons.home, size: 30, color: Colors.black),
              onPressed: _home),
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
                padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('موجودی',
                            style: TextStyle(
                                color:  Color.fromRGBO(140, 83, 62, 10),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                    if (defualtbalance)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('ریال',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          SizedBox(
                            width: 5,
                          ),
                          Text('$balance',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),

                        ],
                      ),
                    if (isbalance)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: CircularProgressIndicator(
                                valueColor:
                                new AlwaysStoppedAnimation<Color>(
                                    Colors.black)),
                            height: 20,
                            width: 20,
                          )
                        ],
                      ),
                    IconButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        icon: Icon(Icons.refresh,
                            size: 30, color: Color.fromRGBO(140, 83, 62, 10),),
                        onPressed: walletPage),
                  ],
                ),
              )
            ]),
            if (changePass)
              Container(
                padding: EdgeInsets.fromLTRB(20, 1, 1, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Center(
                            child: Text(
                          'فراموشی رمز',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                        InkWell(
                          child: Image.asset(
                            "assets/images/changpass.png",
                            width: 80,
                            height: 80,
                          ),
                          onTap: () {
                            Password();
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            Center(
              child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/InventoryWallet.png',
                      ),
                    ],
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(!justMerchant)
                  Container(
                    padding: EdgeInsets.fromLTRB(7, 10, 10, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 135,
                          width: 135,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child:
                              Image.asset('assets/images/Moneytransfer.png'),
                              onPressed: () {
                                Transfer();
                              }),
                        ),
                        Center(
                          child: Text(
                            "انتقال اعتبار",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                if(justMerchant)
                Container(
                    padding: EdgeInsets.fromLTRB(7, 10, 10, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 135,
                          width: 135,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child:
                              Image.asset('assets/images/radar.png'),
                              onPressed: () {}),
                        ),
                        Center(
                          child: Text(
                            "اطراف من",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                if(!justMerchant)
                Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 135,
                          width: 135,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Image.asset('assets/images/charge.png'),
                              onPressed: _charge),
                        ),
                        Center(
                          child: Text(
                            "شارژ",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),

                if (disbandCashOut && justMerchant)
                  Container(
                      padding: EdgeInsets.fromLTRB(7, 10, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 135,
                            width: 135,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(color: Colors.black)),
                                color: Color.fromRGBO(250, 236, 196, 10),
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child:
                                    Image.asset('assets/images/chashout.png'),
                                onPressed: () {
                                  _sendDataToCashout(context);
                                }),
                          ),
                          Center(
                            child: Text(
                              "برداشت",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),

              ],
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  //     child: Column(
                  //       children: [
                  //         SizedBox(
                  //           height: 135,
                  //           width: 135,
                  //           child: RaisedButton(
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(25),
                  //                   side: BorderSide(color: Colors.black)),
                  //               color: Color.fromRGBO(250, 236, 196, 10),
                  //               padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  //               child: Image.asset('assets/images/qr.png'),
                  //               onPressed: () {}),
                  //         ),
                  //         Center(
                  //           child: Text(
                  //             "نمایش کیوآر",
                  //             style: TextStyle(
                  //                 fontSize: 10, fontWeight: FontWeight.bold),
                  //           ),
                  //         ),
                  //       ],
                  //     )),
                  if(!justMerchant)
                  Container(
                      padding: EdgeInsets.fromLTRB(7, 10, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 135,
                            width: 135,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(color: Colors.black)),
                                color: Color.fromRGBO(250, 236, 196, 10),
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Image.asset('assets/images/scan.png'),
                                onPressed: _scan),
                          ),
                          Center(
                            child: Text(
                              "اسکن",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(!justMerchant)
                Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90,
                          width: 90,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Image.asset('assets/images/radar.png'),
                              onPressed: () {}),
                        ),
                        Center(
                          child: Text(
                            "اطراف من",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                // Container(
                //     padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                //     child: Column(
                //       children: [
                //         SizedBox(
                //           height: 90,
                //           width: 90,
                //           child: RaisedButton(
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(25),
                //                   side: BorderSide(color: Colors.black)),
                //               color: Color.fromRGBO(250, 236, 196, 10),
                //               padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                //               child: Image.asset('assets/images/cards.png'),
                //               onPressed: _cardsme),
                //         ),
                //         Center(
                //           child: Text(
                //             "کارتهای من",
                //             style: TextStyle(
                //                 fontSize: 10, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ],
                //     )),

                Container(
                    padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90,
                          width: 90,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.black)),
                              color: Color.fromRGBO(250, 236, 196, 10),
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Image.asset(
                                  'assets/images/transactionlist.png'),
                              onPressed: () {
                                _sendDataToOrders(context);
                              }),
                        ),
                        Center(
                          child: Text(
                            "تاریخچه تراکنش ها",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _scan() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scan();
    }));
  }

  void _orders() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Orders();
    }));
  }

  void _sendDataToOrders(BuildContext context) {
    String textToSend = widget.merchantId;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Orders(
            merchantId: textToSend,
          ),
        ));
  }

  void _charge() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Charge();
    }));
  }

  void _cardsme() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CardsMe();
    }));
  }

  void _home() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }

  void _cashout() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Cashout();
    }));
  }

  void Transfer() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TransferMoney();
    }));
  }

  void isMerchant() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var merchants = JwtDecoder.decode(token)["merchant_roles"];
    if (merchants != null) {
      setState(() {
        is_merchants = true;
      });
    }
  }

  void getAccount() async {
    print('widget.merchantId');
    print(widget.merchantId);
    if (widget.merchantId != null) {
      final userId = widget.merchantId;
      var headers = await Headers();
      await http
          .get(Apis().baseUrl + 'users/v3/accounts/$userId?mod=0',
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 200) {
          var data = resp.body;
          var decode = jsonDecode(data);
          setState(() {
            changePass = true;
            justMerchant = true;

            name = decode['name'];
            role = decode['users'][0]['role'];
            if (role == 'finace') {
              disbandCashOut = false;
            }
            print(role);
          });
        }
      });
    }

    if (widget.merchantId == null) {
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
          });
        }
      });
    }
  }

  void _sendDataToCashout(BuildContext context) {
    String textToSend = DataToken;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Cashout(
            DataToken: textToSend,
          ),
        ));
  }

  void _sendDataToRecaveryPassword(BuildContext context) {
    String textToSend = DataToken;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecaveryPassword(
            DataToken: textToSend,
          ),
        ));
  }

  void _sendDataToPassword(BuildContext context) {
    String textToSend = DataToken;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetPassword(
            DataToken: textToSend,
          ),
        ));
  }

  void Password() {
    if (getCard[0]['protected'] == true) {
      _sendDataToRecaveryPassword(context);
    }
    if (getCard[0]['protected'] == false) {
      _sendDataToPassword(context);
    }
    print("set password");
    print(getCard[0]['protected']);
  }

  void _getcard() async {
    print(widget.merchantId);
    if (widget.merchantId == null) {
      var headers = await Headers();
      await http
          .get(Apis().baseUrl + 'payment/v3/cards?cashout=false&club=true',
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 200) {
          var data = resp.body;
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
    if (widget.merchantId != null) {
      final userid = widget.merchantId;
      var headers = await Headers();
      await http
          .get(Apis().baseUrl + 'payment/v3/accounts/$userid/cards?club=true',
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 200) {
          var data = resp.body;
          var decode = jsonDecode(data);

          Map dictData = {'merchantId': userid, 'DataToken': decode};
          String body = json.encode(dictData);
          print(body.runtimeType);
          print(body);

          setState(() {
            getCard = decode;
            DataToken = body;
            print("Data token is merchant");
            print(dictData);
          });
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
  }

  void walletPage() async {
    _loader();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context, false);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Wallet();
      }));
    });
  }


   _loader() {
    // Navigator.pop(context, false);
    AwesomeDialog(
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
                      "بارگذاری مجدد",
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
}
