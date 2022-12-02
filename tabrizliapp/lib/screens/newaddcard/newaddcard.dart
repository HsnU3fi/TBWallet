import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/setting/setting.dart';

class NewAddCard extends StatefulWidget {
  @override
  _NewAddCardState createState() => _NewAddCardState();
}

class _NewAddCardState extends State<NewAddCard> {
  void _home() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }

  void _setting() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Setting();
    }));
  }

  @override
  String card_number;
  bool _default;
  String exp_y;
  String exp_m;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(252, 246, 225, 10),
        actions: [
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              icon: Icon(Icons.home, size: 30, color: Colors.black),
              onPressed: _home),
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              icon: Icon(Icons.settings,
                  size: 30, color: Color.fromRGBO(140, 83, 62, 10)),
              onPressed: _setting),
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
                child: Text("افزودن کارت های جدید",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Image.asset(
                    'assets/images/cards.png',
                    height: 100,
                  ),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: Text(
                  ".شماره کارت خود را وارد کنید",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: TextField(
                onChanged: (value) {
                  card_number = value;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(250, 236, 196, 10),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: "شماره ۱۶ رقمی کارت",
                ),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Flexible(
                    child: Column(
                  children: [
                    Center(
                      child: Text(
                        "سال",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: new TextField(
                          onChanged: (value) {
                           exp_y = value;
                          },
                          decoration: InputDecoration(
                        fillColor: Color.fromRGBO(250, 236, 196, 10),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                        ),
                      )),
                    ),
                  ],
                )),
                SizedBox(width: 5),
                new Flexible(
                    child: Column(
                  children: [
                    Center(
                      child: Text(
                        "ماه",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: new TextField(
                          onChanged: (value) {
                            exp_m = value;
                          },
                          decoration: InputDecoration(
                        fillColor: Color.fromRGBO(250, 236, 196, 10),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40))),
                      )),
                    )
                  ],
                )),
              ],
            ),
            Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(0, 50, 10, 0),
                    child: InkWell(
                      onTap: () {
                        _addCard();
                      },
                      child: Image.asset(
                        "assets/images/success.png",
                        height: 50,
                        width: 50,
                      ),
                    )),
                Center(
                  child: Text(
                    "ذخیره",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                alignment: Alignment.bottomRight,
                child: LiteRollingSwitch(
                  //initial value

                  value: true,
                  textOn: 'پیش فرض',
                  textOff: 'خاموش',
                  colorOn: Colors.greenAccent[700],
                  colorOff: Colors.red[700],
                  iconOn:  Icons.credit_card,
                  iconOff:Icons.flash_off,
                  textSize: 15,
                  onChanged: (bool state) {
                    _default = state;
                  },
                ),
              )
            ],
          )
          ],
        ),
      ),
    );
  }

  void _addCard() async {
    this._loader();

    Map data = {
      "card_number": card_number,
      "default": _default,
      "exp_y": exp_y,
      "exp_m": exp_m
    };

    var headers = await Headers();
    String body = jsonEncode(data);

    http
        .post(Apis().baseUrl + 'payment/v3/cards', body: body, headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        Navigator.pop(context,false);
        _showSnackBarSuccess(context);
      } else {
        Navigator.pop(context,false);
        this._showSnackBarErorr(context);
      }
    });
  }

  _loader() {
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

  void _showSnackBarSuccess(BuildContext context) {
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

}
