import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/cashout/recoverypassword.dart';
import 'ordersCashOut.dart';

class Cashout extends StatefulWidget {
  final String DataToken;

  Cashout({key, @required this.DataToken}) : super(key: key);

  @override
  _CashoutState createState() => _CashoutState();
}

class _CashoutState extends State<Cashout> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getibans();
    getDataAccount();
  }

  @override
  bool is_merchants = false;
  String amount;
  List suggestions = [];
  String iban;
  String ibanDefault;
  String pin;
  String cardtoken;
  String name;
  String image;
  String token;
  String pubkey;
  int bankcode;
  String message;
  String DatetimeTrnc;
  String Trcno;
  String RRN;
  String Name;
  String AmountTrnC;
  String TypeTrnc;
  bool falseIban = false;
  bool tureIban = false;

  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  List<String> ibanList = [];

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
                icon: Icon(Icons.list, size: 30, color: Colors.black),
                onPressed: () {
                  ordersCashOt(context);
                }),
            IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                icon: Icon(Icons.home, size: 30, color: Colors.black),
                onPressed: _home),
          ],
        ),
        body: Container(
          child: Center(
            child: ListView(
              children: [
                Container(
                  color: Color.fromRGBO(224, 161, 72, 10),
                  height: MediaQuery.of(context).size.height,
                  child: ContainedTabBarView(
                    tabs: [
                      Text(
                        'کیف پول',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      if (is_merchants)
                        Text('عادی',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                    ],
                    views: [
                      if (is_merchants)
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          color: Color.fromRGBO(140, 83, 62, 10),
                          child: ListView(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                child: Image.asset(
                                  'assets/images/chashout.png',
                                  height: 100,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 20, 20, 0),
                                      child: Text(
                                        ".مبلغ برداشت را مشخص کنید",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: TextField(
                                  inputFormatters: [
                                    ThousandsSeparatorInputFormatter()
                                  ],
                                  onChanged: (value) {
                                    amount = value;
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    fillColor:
                                        Color.fromRGBO(250, 236, 196, 10),
                                    filled: true,
                                    isDense: true,
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
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: InkWell(
                                        onTap: walletCashOut,
                                        child: Image.asset(
                                          "assets/images/success.png",
                                          height: 50,
                                          width: 50,
                                        ),
                                      )),
                                  Center(
                                    child: Text(
                                      "تایید",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  height: 350,
                                  width: 320,
                                  child: Column(
                                    children: [
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 20, 20, 0),
                                          child: Text(
                                            "مبلغ را وارد کنید تا موجودی فروشگاه به \n موجودی کیف پول شخصی شما انتقال یابد",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white70),
                                          )),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      Container(
                          // height:MediaQuery.of(context).size.height,
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          color: Color.fromRGBO(140, 83, 62, 10),
                          child: LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return ListView(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (false)
                                        RawMaterialButton(
                                          onPressed: () {
                                            ordersCashOt(context);
                                          },
                                          elevation: 2.0,
                                          fillColor: Colors.amber,
                                          child: Icon(
                                            Icons.list,
                                            size: 35.0,
                                          ),
                                          padding: EdgeInsets.all(15.0),
                                          shape: CircleBorder(),
                                        )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                  child: Image.asset(
                                    'assets/images/chashout.png',
                                    height: 100,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 20, 20, 0),
                                        child: Text(
                                          ".مبلغ برداشت را مشخص کنید",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                                  child: TextField(
                                    inputFormatters: [
                                      ThousandsSeparatorInputFormatter()
                                    ],
                                    onChanged: (value) {
                                      amount = value;
                                    },
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      fillColor:
                                          Color.fromRGBO(250, 236, 196, 10),
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      hintText: "مبلغ(ریال)",
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 20, 0),
                                    child: Text(
                                      ".شماره شبا خود را وارد کنید",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                                  child: SimpleAutoCompleteTextField(
                                      decoration: InputDecoration(
                                        hintText:
                                            "شماره شبا 24 رقمی خود را وارد کنید",
                                        isDense: true,
                                        fillColor:
                                            Color.fromRGBO(250, 236, 196, 10),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                      textChanged: (value) => setState(() {
                                            iban = (value.replaceAll(RegExp('IR'), ''));
                                          }),
                                      clearOnSubmit: false,
                                      textSubmitted: (value) => setState(() {
                                            iban = value.replaceAll(RegExp('IR'), '');
                                          }),
                                      controller:
                                          TextEditingController(text: iban),
                                      // keyboardType: TextInputType.number,
                                      key: key,
                                      suggestions: ibanList),
                                  // textAlign: TextAlign.center,
                                ),
                                if (falseIban)
                                  Column(
                                    children: [
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 20, 0, 0),
                                          child: InkWell(
                                            onTap: _enquiry,
                                            child: Image.asset(
                                              "assets/images/success.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          )),
                                      Center(
                                        child: Text(
                                          "تایید",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (tureIban)
                                  Column(
                                    children: [
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 20, 0, 0),
                                          child: InkWell(
                                            onTap: showDefault,
                                            child: Image.asset(
                                              "assets/images/success.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          )),
                                      Center(
                                        child: Text(
                                          "تایید",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            );
                          })),
                    ],
                    onChange: (index) => print(index),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  final TextEditingController textEditingController = TextEditingController();
//==============================================================================
  void _home() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }
//==============================================================================
  void ordersCashOt(BuildContext context) {
    var decode = jsonDecode(widget.DataToken);
    var merchnatid = decode['merchantId'];
    String textToSend = merchnatid;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrdersCashOut(
            merchantId: textToSend,
          ),
        ));
  }
//==============================================================================
  void _getibans() async {
    final DataToken = widget.DataToken;
    final decode = json.decode(DataToken);
    final backgroundImage = decode['DataToken'][0]["background_image"];
    final bankCode = decode['DataToken'][0]["bank_code"];
    final cardToken = decode['DataToken'][0]["token"];
    setState(() {
      is_merchants = true;
      image = backgroundImage;
      bankcode = bankCode;
      cardtoken = cardToken;
    });

    var decodeDataToken = jsonDecode(widget.DataToken);
    var _id = decodeDataToken['merchantId'];
    var headers = await Headers();
    await http
        .get(Apis().baseUrl + 'payment/v3/accounts/${_id}/ibans',
            headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var data = resp.body;

        print("chiye dakhel in data??");

        print(data);

        print(data.length);
        if (data.length == 3) {
          setState(() {
            tureIban = true;
          });
          print(" false sheba number");
          print(tureIban);
        }

        var decode = jsonDecode(data);
        for (var a in decode) {
          setState(() {
            ibanList.add(a['iban']);
            if (a['default'] = true) {
              setState(() {
                falseIban = true;
                iban = a["iban"];
              });
            }
          });
        }
      }
    });

    // if (widget.DataToken != null) {
    //   final DataToken = widget.DataToken;
    //   final decode = json.decode(DataToken);
    //   final userid = decode['merchantId'];
    //   var headers = await Headers();
    //   await http
    //       .get(Apis().baseUrl + 'payment/v3/accounts/${userid}/ibans',
    //           headers: headers)
    //       .then((resp) {
    //     if (resp.statusCode == 200) {
    //       var data = resp.body;
    //       var decode = jsonDecode(data);
    //       print('sag sag');
    //       print(data);
    //       for (var a in decode) {
    //         setState(() {
    //           ibanList.add(a['iban']);
    //           if (a['default'] = true) {
    //             setState(() {
    //               ibanDefault = a["iban"];
    //             });
    //           }
    //         });
    //       }
    //     }
    //   });
    // }
  }
//==============================================================================
  _cashout() async {
    final amount1 = amount.replaceAll(RegExp(','), '');
    var Amount = int.parse(amount1);
    if (widget.DataToken == null) {
      this._loader();
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

      Map data = {
        "amount": Amount,
        "user_id": userId,
        "password": pin,
        "cash_out_type": 10,
        "destination": "IR${iban}",
      };

      print(data);
      var headers = await Headers();
      String body = jsonEncode(data);
      http
          .post(Apis().baseUrl + 'dispatcher/v1/paya/request',
              body: body, headers: headers)
          .then((resp) {
        if (resp.statusCode == 201) {
          Navigator.pop(context, false);
          var data = json.decode(resp.body);
          if (data['message'] != null) {
            setState(() {
              message = data['message'];
            });
            Navigator.pop(context, false);
            this._showSnackBarMessage(context);
          } else {
            this._showSnackBarSucss(context);
            this._home();
          }
        }
      }).catchError((e) => {
                Navigator.pop(context, false),
                this._showSnackBarErorr(context)
              });
      // _showSnackBarWait(context);
    }
    if (widget.DataToken != null) {
      this._loader();
      final DataToken = widget.DataToken;
      final decode = json.decode(DataToken);
      final userid = decode['merchantId'];
      setState(() {
        cardtoken = decode['DataToken'][0]['token'];
      });
      Map data = {
        "amount": Amount,
        "user_id": userid,
        "password": pin,
        "cash_out_type": 10,
        "destination": "IR${iban}",
      };
      print(data);
      var headers = await Headers();
      String body = jsonEncode(data);
      http
          .post(Apis().baseUrl + 'dispatcher/v1/paya/request',
              body: body, headers: headers)
          .then((resp) {
        if (resp.statusCode == 201) {
          var dataMerchant = json.decode(resp.body);
          Navigator.pop(context, false);
          if (dataMerchant['message'] != null) {
            setState(() {
              message = dataMerchant['message'];
            });
            Navigator.pop(context, false);
            this._showSnackBarMessage(context);
          } else {
            this._showSnackBarSucss(context);
            this._home();
          }
        }
      }).catchError((e) => {
                Navigator.pop(context, false),
                this._showSnackBarErorr(context)
              });
    }
  }
//==============================================================================
  _enquiry() async {
    final amount1 = amount.replaceAll(RegExp(','), '');
    var Amount = int.parse(amount1);

    if (Amount >= 10000) {
      Map data = {
        "info_type": 10,
        "destination": "IR${iban}",
      };
      var headers = await Headers();
      String body = jsonEncode(data);
      this._loader();
      http
          .post(Apis().baseUrl + 'dispatcher/v1/paya/enquiry_of_name',
              body: body, headers: headers)
          .then((resp) {
        if (resp.statusCode == 200) {
          var res = jsonDecode(resp.body);
          Navigator.pop(context, false);
          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
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
                onPressed: _password),
            btnCancel: RaisedButton(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textColor: Colors.white,
              child: Text(
                "لغو",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            dialogType: DialogType.INFO,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "مبلغ: ${amount}﷼",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "نام: ${res['account_owners'][0]['first_name']}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "نام خانوادگی: ${res['account_owners'][0]['last_name']}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${res['destination']}",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " :شماره شبامقصد",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
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
                      "نام بانک: ${res['bank_name']}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          )..show();
        } else {
          Navigator.pop(context, false);
          this._showSnackBarErorr(context);
        }
      }).catchError((e) => {
                Navigator.pop(context, false),
                this._showSnackBarErorr(context)
              });
    } else {
      this._showSnackBarErorrAmount(context);
    }
  }
//==============================================================================
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
          TextField(
            onChanged: (value) {
              pin = value;
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(250, 236, 196, 10),
              filled: true,
              isDense: true,
              hintText: "******",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 85,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(
                      "لغو",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 85,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(
                      "فراموشی رمز",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    onPressed: _RecaveryPassword,
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 85,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        "تایید",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: _cashout),
                )
              ],
            ),
          )
        ],
      ),
    )..show();
  }
//==============================================================================
  showDefault() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      body: Column(
        children: [
          Text(
            "آیا مایل به ذخیره این شماره شبا به عنوان شماره شبا پیش فرض خود هستید؟ "
            "دقت کنید!درصورت انتخاب پیشفرض از این پس تمام برداشت های عادی اتوماتیک باشماره شبا پیش فرض انجام می شود",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
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
          onPressed: setDefaultShebaNumber),
      btnCancel: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            "خیر",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          color: Colors.red,
          textColor: Colors.white,
          onPressed: _enquiry),
    )..show();
  }
//==============================================================================
  setDefaultShebaNumber() async {
    this._loader();
    final DataToken = widget.DataToken;
    final decode1 = json.decode(DataToken);
    final merchantId = decode1['merchantId'];

    Map data = {"default": true, "iban": "IR${iban}"};

    var headers = await Headers();
    String body = jsonEncode(data);
    http
        .post(Apis().baseUrl + 'payment/v3/accounts/${merchantId}/ibans',
            body: body, headers: headers)
        .then((resp) {
      if (resp.statusCode == 201) {
        _enquiry();
        Navigator.pop(context, false);
        // this._showSnackBarSuccessShebaNumber(context);
      }else{
       Navigator.pop(context,false);
       this._showSnackBarErorr(context);
      }
    }).catchError((e) =>
            {Navigator.pop(context, false), this._showSnackBarErorr(context)});
  }
//==============================================================================
  _passwordMerchant() {
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
          TextField(
            onChanged: (value) {
              pin = value;
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(250, 236, 196, 10),
              filled: true,
              isDense: true,
              hintText: "******",
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
          onPressed: intWallet),
    )..show();
  }
//==============================================================================
  getDataAccount() async {
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
          print(name);
        });
      }
    });
  }
//==============================================================================
  walletCashOut() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      body: Column(
        children: [
          Text(
            "پرداخت: ${name}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          TextFormField(
            controller: TextEditingController(text: amount),
            onChanged: (value) {
              value = amount;
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(250, 236, 196, 10),
              filled: true,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
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
              this._passwordMerchant();
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    )..show();
  }
//==============================================================================
  intWallet() async {
    this._loader();
    final DataToken = widget.DataToken;
    final decode1 = json.decode(DataToken);
    final merchantId = decode1['merchantId'];

    final getDataUser = await User_Id();
    final decode = jsonDecode(getDataUser);
    final adminId = decode['user_id'];
    final amount1 = amount.replaceAll(RegExp(','), '');

    Map data = {
      "amount": int.parse(amount1),
      "from": merchantId,
      "to": adminId,
      "credit": true
    };

    var headers = await Headers();
    String body = jsonEncode(data);
    http
        .post(Apis().baseUrl + 'payment/v3/init', body: body, headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var res = jsonDecode(resp.body);
        setState(() {
          token = res['token'];
          pubkey = res['pub_key'];
        });
        print('biya biya');
        print(res);
        this.payWallet();
      } else {
        Navigator.pop(context, false);
        this._showSnackBarErorPay(context);
      }
    }).catchError((e) =>
            {Navigator.pop(context, false), this._showSnackBarErorr(context)});
  }
//==============================================================================
  payWallet() async {
    var now = DateTime.now().millisecondsSinceEpoch;
    Map cardifno = {
      'c': cardtoken,
      'bc': bankcode,
      'p2': pin,
      'type': 1,
      't': now,
    };
    print('cardifno');
    print(cardifno);

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
        print("salam salam");
        print(resp.body);
        this.Succes();
      } else {
        Navigator.pop(context, false);
        this._showSnackBarErorPay(context);
      }
    }).catchError((e) => {
              Navigator.pop(context, false),
              this._showSnackBarErorPay(context)
            });
  }
//==============================================================================
  Succes() {
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
                  "نام یا شماره موبایل گیرنده",
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
//==============================================================================
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
//==============================================================================
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

  void _showSnackBarSucss(BuildContext context) {
    Navigator.pop(context, false);
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
//==============================================================================
  void _showSnackBarSuccessShebaNumber(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('.شماره شبا بصورت پیش فرض ثبت شد',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
//==============================================================================
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
//==============================================================================
  void _showSnackBarErorrAmount(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('مبلغ ورودی کمتر از 10000 ریال است.',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
//==============================================================================
  void _RecaveryPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecaveryPassword()));
  }
//==============================================================================
  void _showSnackBarMessage(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('$message',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
//==============================================================================
class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
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
