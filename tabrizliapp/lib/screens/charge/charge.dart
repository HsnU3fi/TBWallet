import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/setting/setting.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'dart:js' as js;


class Charge extends StatefulWidget {
  @override
  _ChargeState createState() => _ChargeState();
}

class _ChargeState extends State<Charge> {
  void _setting() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Setting();
    }));
  }

  @override
  String amount;
  // var translator = MaskedTextController.getDefaultTranslator(); // get new instance of default translator.
  // var sag= translator.remove(','); // removing wildcard translator.
  var controller = new MoneyMaskedTextController(thousandSeparator:',');

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
        actions: [
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
                padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                child: Text("شارژ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ]),
            Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Image.asset(
                'assets/images/charge.png',
                height: 100,
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: Text(
                  ".مبلغ واریزی را مشخص کنید",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: TextField(
                inputFormatters: [ThousandsSeparatorInputFormatter()],
              // controller:,
                onChanged: (value) {
                  setState(() {
                    amount = value;
                  });
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(250, 236, 196, 10),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: "مبلغ(ریال)",
                ),
              ),
            ),
            Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: InkWell(
                      onTap: _charge,
                      child: Image.asset(
                        "assets/images/success.png",
                        height: 50,
                        width: 50,
                      ),
                    )),
                Center(
                  child: Text(
                    "تایید",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _home() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }

  _charge() async {
   this._loader();
    final getDataUser = await User_Id();
    final decode = jsonDecode(getDataUser);
    final userId = decode['user_id'];
    final amount1 = amount.replaceAll(RegExp(','),'');

    Map data = {
      "amount": int.parse(amount1),
      "to": userId,
      "credit": false,
      "transaction_type": 4,
      "order_type": 2,
    };
    var headers = await Headers();
    String body = jsonEncode(data);
    http
        .post(Apis().baseUrl + 'payment/v3/init', body: body, headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        Navigator.pop(context, false);
        var res = jsonDecode(resp.body);
        var ipgUrl = res['ipg_url'];
        AwesomeDialog(
          context: context,
          dialogType: DialogType.NO_HEADER,
          body: Column(
            children: [
              Text(
                ".برای ثبت درخواست کلیک کنید",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          btnOk: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text(
                "شارژ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                js.context.callMethod('open', [ipgUrl]);
              }
          ),
          btnCancel: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text(
                "لغو",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context,false);
              }
          ),
        )
          ..show();
      } else{
        _showSnackBarErorr(context);
        Navigator.pop(context, false);

    }
    }).catchError((e) => {
      Navigator.pop(context, false),
      this._showSnackBarErorr(context)
    });
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


  // void _showSnackBarWait(BuildContext context) {
  //   final snackBar = SnackBar(
  //     content: Text('.لطفا منتظر بمانید',
  //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  //         textAlign: TextAlign.center),
  //     behavior: SnackBarBehavior.floating,
  //     width: 300,
  //     duration: Duration(seconds: 3),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

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
    print("newValue");
    print(newValue);

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}


class MoneyFormat {
  String price;

  String moneyFormat(String price) {
    if (price.length > 2) {
      var value = price;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return value;
    }
  }
}