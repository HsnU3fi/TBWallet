import 'dart:convert';
import 'dart:core';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/setting/setting.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:http/http.dart' as http;

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  void _setting() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Setting();
    }));
  }
//TODO: fucking flutter pwa
  String QR;
  String account_id;
  String name;
  String Amount;
  String image;
  String cardtoken;
  String password;
  String token;
  String pubkey;
  int bankcode;
  String DatetimeTrnc;
  String Trcno;
  String RRN;
  String Name;
  String AmountTrnC;
  String TypeTrnc;
  int balance = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getcard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(252, 246, 225, 10),
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              icon: Icon(Icons.home, size: 30, color: Colors.black),
              onPressed: _home),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                                  color: Color.fromRGBO(140, 83, 62, 10),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('ریال',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          SizedBox(
                            width: 2,
                          ),
                          Text('$balance',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.black)),
                            height: 20,
                            width: 20,
                          )
                        ],
                      ),
                      IconButton(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          icon: Icon(
                            Icons.refresh,
                            size: 30,
                            color: Color.fromRGBO(140, 83, 62, 10),
                          ),
                          onPressed: scannerPage),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: FittedBox(
                child: Image.asset(
                  'assets/images/qr_center.png',
                  color: Colors.white,
                ),
              ),
              height: 250,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Column(
                //   children: [
                //     Container(
                //       padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //       child: SizedBox(
                //         height: 70,
                //         width: 70,
                //         child: RaisedButton(
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(25),
                //                 side: BorderSide(color: Colors.black)),
                //             color: Color.fromRGBO(250, 236, 196, 10),
                //             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                //             child: Image.asset('assets/images/galery.png'),
                //             onPressed: () {
                //               this._showSnackBar(context);
                //             }),
                //       ),
                //     ),
                //     Center(
                //       child: Text(
                //         "گالری",
                //         style: TextStyle(
                //           fontSize: 10,
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
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
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/codeqr.png'),
                            onPressed: _QrCode),
                      ),
                    ),
                    Center(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                      child: Text(
                        "کد کیوآٰر",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  ],
                ),
                // Column(
                //   children: [
                //     Container(
                //       padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //       child: SizedBox(
                //         height: 70,
                //         width: 70,
                //         child: RaisedButton(
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(25),
                //                 side: BorderSide(color: Colors.black)),
                //             color: Color.fromRGBO(250, 236, 196, 10),
                //             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                //             child: Image.asset('assets/images/flash.png'),
                //             onPressed: () {
                //               this._showSnackBar(context);
                //             }),
                //       ),
                //     ),
                //     Center(
                //       child: Text(
                //         "چراغ قوه",
                //         style: TextStyle(
                //           fontSize: 10,
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _QrCode() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      body: Column(
        children: [
          Text(
            ".کد کیوآر پذیرنده را وارد کنید",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          TextFormField(
            onChanged: (value) {
              QR = value;
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(250, 236, 196, 10),
              filled: true,
              isDense: true,
              hintText: "کد کیوآر پذیرنده",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ],
      ),
      btnOk: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            "تایید",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          color: Colors.green,
          textColor: Colors.white,
          onPressed: _getInfoQr),
    )..show();
  }

  _paymentQrcode() {
    Navigator.pop(context, false);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 50,
                // color: Colors.orangeAccent,
                child: Text(
                  "پرداخت به: ${name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          TextFormField(
            onChanged: (value) {
              Amount = value;
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(250, 236, 196, 10),
              filled: true,
              isDense: true,
              hintText: "﷼",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          LiteRollingSwitch(
            //initial value
            value: true,
            textOn: 'کیف پول',
            textOff: 'کارت',
            colorOn: Colors.greenAccent[700],
            colorOff: Colors.yellow[700],
            iconOn: Icons.account_balance_wallet,
            iconOff: Icons.credit_card,
            textSize: 20,
            onChanged: (bool state) {},
          ),
        ],
      ),
      btnOk: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            "تایید",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          color: Colors.green,
          textColor: Colors.white,
          onPressed: () {
            this._Payment();
          }),
    )..show();
  }

  _Payment() {
    Navigator.pop(context, false);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 50,
                // color: Colors.orangeAccent,
                child: Text(
                  "پرداخت به: ${name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'مبلغ قابل پرداخت (﷼): ${Amount}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '.یک کارت را جهت پرداخت انتخاب کنید',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            child: Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://api.paygear.ir/files/v3/${image}?cache-first'),
                    fit: BoxFit.fill,
                  )),
            ),
            onTap: () {
              this._password();
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    )..show();
  }

  void _home() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }

  void _password() {
    Navigator.pop(context, false);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      body: Column(
        children: [
          Text(
            ".رمز خود را وارد کنید",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          TextFormField(
            onChanged: (value) {
              password = value;
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(250, 236, 196, 10),
              filled: true,
              isDense: true,
              hintText: "*******",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ],
      ),
      btnOk: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            "تایید",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          color: Colors.green,
          textColor: Colors.white,
          onPressed: _int),
      btnCancel: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            "انصراف",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          color: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context, false);
          }),
    )..show();
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
              image = a['background_image'];
              bankcode = a["bank_code"];
              cardtoken = a['token'];
              balance = a['balance'];
            }
          });
        }
      }
    });
  }

  void _getInfoQr() async {
    var headers = await Headers();
    await http
        .get(Apis().baseUrl + 'qrcode/v3/qr/${QR}', headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        this._getInfoAccount();
        var data = resp.body;
        var decode = jsonDecode(data);
        setState(() {
          account_id = decode['account_id'];
        });
      } else {
        this._showSnackBarEror(context);
      }
    });
  }

  void _getInfoAccount() async {
    var headers = await Headers();
    await http
        .get(Apis().baseUrl + 'users/v3/accounts/${account_id}?mod=0',
            headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var data = resp.body;
        var decode = jsonDecode(data);
        setState(() {
          name = decode['name'];
        });
        this._paymentQrcode();
      } else {
        this._showSnackBarEror(context);
      }
    });
  }

  void _int() async {
    Map data = {
      "amount": Amount,
      "to": account_id,
      "credit": true,
      "transaction_type": 1,
    };
    var headers = await Headers();
    String body = jsonEncode(data);
    http
        .post(Apis().baseUrl + 'payment/v3/init', body: body, headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var data = resp.body;
        var decode = jsonDecode(data);
        setState(() {
          token = decode['token'];
          pubkey = decode['pub_key'];
        });
        this._pay();
      } else {
        this._showSnackBarEror(context);
      }
    });
  }

  void _pay() async {
    this._showSnackBarWait();

    // baraye pay niyaze card info ro encrypt kard
    // baraye encrypt niyaz be publykey hast ke ba format RSA anjam beshe

    var now = DateTime.now().millisecondsSinceEpoch;
    Map cardifno = {
      'c': cardtoken,
      'bc': bankcode,
      'p2': password,
      'type': 1,
      't': now,
    };

    final CardInfo = jsonEncode(cardifno);
    final parser = RSAKeyParser();
    var publicKey = parser.parse(pubkey);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    final encrypted = encrypter.encrypt(CardInfo);

    Map data = {
      "card_info": encrypted.base64,
      "token": token,
    };

    var headers = await Headers();
    String body = jsonEncode(data);

    http
        .post(Apis().baseUrl + 'payment/v3/pay', body: body, headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        this.verify();
      } else {
        this._showSnackBarErorPay(context);
      }
    });
  }

  void verify() async {
    Map data = {
      "token": token,
    };
    var headers = await Headers();
    String body = jsonEncode(data);
    http
        .post(Apis().baseUrl + 'payment/v3/verify',
            body: body, headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var data = resp.body;
        var decode = jsonDecode(data);
        setState(() {
          DatetimeTrnc = decode['result'][4]['value'];
          Trcno = decode['result'][2]['value'];
          RRN = decode['result'][3]['value'];
          Name = decode['result'][0]['value'];
          AmountTrnC = decode['result'][5]['value'];
          TypeTrnc = decode['result'][1]['value'];
        });

        this._SUCCES();
      } else {
        this._showSnackBarErorPay(context);
      }
    });
  }

  void _SUCCES() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "پرداخت موفق",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 1, 1, 0),
                child: Text(
                  "${Name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(1, 1, 50, 0),
                child: Text(
                  "نام گیرنده",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 1, 1, 0),
                child: Text(
                  "${TypeTrnc}",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(1, 1, 50, 0),
                child: Text(
                  "نوع تراکنش",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 1, 1, 0),
                child: Text(
                  "${Trcno}",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(1, 1, 50, 0),
                child: Text(
                  "کد رهگیری",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 1, 1, 0),
                child: Text(
                  "${RRN}",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(1, 1, 50, 0),
                child: Text(
                  "شماره پرداخت",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 1, 1, 0),
                child: Text(
                  "${DatetimeTrnc}",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(1, 1, 50, 0),
                child: Text(
                  "تاریخ",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 1, 1, 0),
                child: Text(
                  "${AmountTrnC}",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(1, 1, 50, 0),
                child: Text(
                  "مبلغ پرداختی",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          )
        ],
      ),
      btnOk: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            "تایید",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          color: Colors.green,
          textColor: Colors.white,
          onPressed: _home),
    )..show();
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('غیرفعال',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSnackBarWait() {
    Navigator.pop(context, false);
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

  void _showSnackBarEror(BuildContext context) {
    Navigator.pop(context, false);
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

  void _showSnackBarErorPay(BuildContext context) {
    Navigator.pop(context, false);
    final snackBar = SnackBar(
      content: Text('پرداخت با مشکل مواجه شد',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void scannerPage() async {
    _loader();
    Future.delayed(Duration(seconds: 2), () async{
      Navigator.pop(context, false);
      this._getcard();
      // await Future.value({});
      // Navigator.push(context, MaterialPageRoute(builder: (context) =>super.widget));
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
