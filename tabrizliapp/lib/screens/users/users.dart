import 'dart:convert';
// import 'dart:html';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/setting/securety/setpassword.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getprovince();
  }

  List items = [];
  int idProvince;
  String name;
  String natinal_code;


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(252, 246, 225, 10),
        child: Center(
          child: Container(
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
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            // height: 1500,
            width: 900,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(0, 150, 20, 0),
                    child: Text(
                      ".نام و نام خانوادگی خود را وارد کنید",
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(250, 236, 196, 10),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: "نام و نام خانوادگی",
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: Text(
                      ".استان خود را انتخاب کنید",
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                    child: InputDecorator(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(250, 236, 196, 10),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "نام استان",
                              ),
                            ),
                            value: idProvince,
                            isExpanded: true,
                            isDense: true,
                            onChanged: (Value) {
                              setState(() {
                                idProvince = Value;
                              });
                            },
                            items: items
                                .map(
                                  (Province) => DropdownMenuItem(
                                    value: Province['id'],
                                    child: Container(
                                      // decoration: BoxDecoration(
                                      //   boxShadow: [
                                      //     BoxShadow(
                                      //       color: Colors.grey.withOpacity(0.8),
                                      //       spreadRadius: 10,
                                      //       blurRadius: 5,
                                      //       offset: Offset(0, 7), // changes position of shadow
                                      //     ),
                                      //   ],
                                      // ),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "${Province['title']}",
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ))),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: Text(
                      ".کدملی خود را وارد کنید",
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: TextField(
                    onChanged: (value) {
                      natinal_code = value;
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(250, 236, 196, 10),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: "کدملی",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: RaisedButton(

                    onPressed: _newUser,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)),
                    textColor: Colors.white,
                    color: Colors.green,
                    splashColor: Color.fromRGBO(252, 246, 225, 10),
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      "تایید",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getprovince() async {
    var headers = await Headers();
    await http
        .get(Apis().baseUrl + 'geo/v3/provinces', headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var data = resp.body;
        var decode = jsonDecode(data);
        setState(() {
          items = decode;
        });
      }
    });
  }

  void _newUser() async {
    if (natinal_code != null && name != null ) {
      this._showSnackBarWait();
      final getDataUser = await User_Id();
      final decode = jsonDecode(getDataUser);
      final userId = decode['user_id'];
      var headers = await Headers();

      Map data = {
        'national_code': natinal_code,
        'account_type': 2,
        'province_id': idProvince,
        "name": name,
      };

      String body = json.encode(data);
      http
          .put(Apis().baseUrl + 'users/v3/accounts/${userId}',
              body: body, headers: headers)
          .then((resp) {
        if (resp.statusCode == 204) {
          this._showSnackBar(context);
          this.setpassword();

        }
      });
    } else {
      this._showSnackBarErorr(context);
    }
  }

  void _showSnackBarErorr(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('.لطفا فیلدها را پر کنید',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSnackBarWait() {
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

  void _showSnackBar(BuildContext context) {
    Navigator.pop(context,false);
    final snackBar = SnackBar(
      content: Text('.با موفقیت انجام شد',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  setpassword()async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SetPassword()));
  }
}
