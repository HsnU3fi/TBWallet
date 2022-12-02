import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';

class TransferMoney extends StatefulWidget {
  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  String amount;
  String mobilePhone;
  String backGround;
  int balance;
  String name;
  String password;
  String token;
  String pubKey;
  String accountId;
  String cardToken;
  String bankCode;
  String DatetimeTrnc;
  String Trcno;
  String RRN;
  String Name;
  String AmountTrnC;
  String TypeTrnc;
  List dataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCard();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color.fromRGBO(252, 246, 225, 10),
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                child: Text("انتقال اعتبار",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: Text(
                      'مبلغ و شماره تلفن همراه کسی که میخواهید برایش پول ارسال کنید را وارد کنید',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: TextField(
                // inputFormatters: [ThousandsSeparatorInputFormatter()],

                onChanged: (value) {
                  amount = value;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(250, 236, 196, 10),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: "مبلغ",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: TextField(
                onChanged: (value) {
                  mobilePhone = value;
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
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RaisedButton(
                onPressed: getAccounts,
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
    );
  }

  getCard() async {
    final prefs = await SharedPreferences.getInstance();
    final card = prefs.getString('getcard');
    print(card);
    print(card.runtimeType);
    var decode = jsonDecode(card);
    print(decode.runtimeType);

    var decode2 = jsonDecode(decode);
    print(decode2.runtimeType);


    for (var a in decode2) {
      setState(() {
        if (a["club_id"] == null && a["bank_code"] == 69) {
          dataList = decode2;
          backGround = a['background_image'];
          balance = a['balance'];
          cardToken = a['token'];
          bankCode = a['bank_code'];
        }
      });
    }
  }

  getAccounts() async {
    if (mobilePhone != null) {
      Map data = {
        'mobile_phones': [mobilePhone]
      };
      String body = json.encode(data);
      var headers = await Headers();
      http
          .post(Apis().baseUrl + 'users/v3/accounts/mobile_phones/bulk?mod=0',
              body: body, headers: headers)
          .then((resp) {
        if (resp.statusCode == 200) {
          var decode = jsonDecode(resp.body);

          var name1 = decode[0]['name'];
          var mobilePhone = decode[0]['mobile_phone'];
          var account_Id = decode[0]['_id'];

          setState(() {
            name = name1;
            accountId = account_Id;
            if (name == null || name == "") {
              setState(() {
                name = mobilePhone;
              });
            }
          });

          _paymentByPhone();
        }
      });
    }
  }

  _paymentByPhone() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'مبلغ قابل پرداخت (﷼): ${amount}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
          SizedBox(
            height: 20,
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
                        'https://api.paygear.ir/files/v3/${backGround}?cache-first'),
                    fit: BoxFit.fill,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'موجودی:${balance}ریال',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            onTap: _password,
          ),
        ],
      ),
    )..show();
  }

  _password() {
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

  _int() async {
    _showSnackBarWait();
    Map data = {
      "amount": int.parse(amount),
      "to": accountId,
      "credit": true,
      "transaction_type": 4,
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
          pubKey = decode['pub_key'];
        });
        this._pay();
      } else {
        this._showSnackBarEror(context);
      }
    });
  }

  _pay() async {
    var now = DateTime.now().millisecondsSinceEpoch;

    Map cardInfo = {
      'c': cardToken,
      'bc': bankCode,
      'p2': password,
      'type': 1,
      't': now,
    };

    final CardInfo = jsonEncode(cardInfo);
    final parser = RSAKeyParser();
    var publicKey = parser.parse(pubKey);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    final encrypted = encrypter.encrypt(CardInfo);

    Map data = {
      "card_info": encrypted.base64,
      "no_verify": false,
      "token": token,
    };

    var headers = await Headers();
    String body = jsonEncode(data);

    http
        .post(Apis().baseUrl + 'payment/v3/pay', body: body, headers: headers)
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
        success();
      } else {
        this._showSnackBarEror(context);
      }
    });
  }

  success() {
    Navigator.pop(context, false);
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

  _showSnackBarWait() {
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

  void _home() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }
}
class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}