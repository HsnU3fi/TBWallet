import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
// import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:persian_datepicker/persian_datepicker.dart';

import 'package:flutter/cupertino.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';

class EditUsers extends StatefulWidget {
  @override
  _EditUsersState createState() => _EditUsersState();
}

class _EditUsersState extends State<EditUsers> {
  @override
  final TextEditingController textEditingController = TextEditingController();

  PersianDatePickerWidget persianDatePicker;

  void initState() {
    // TODO: implement initState
    persianDatePicker = PersianDatePicker(
        controller: textEditingController,
        weekCaptionsBackgroundColor: Color.fromRGBO(241, 201, 82, 10),
        headerTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        // datetime: Birth,
        // farsiDigits: true,
        onChange: (String oldText, String newText) {
          print(newText);
          birthDate = Date().persion(newText);
          print(birthDate);
        }
        ).init();

    super.initState();
    _getprovince();
    _getdata();
  }

  @override
  List items = [];
  int idProvince;
  String name;
  String Birth;
  String BirthDatee;
  String birthDate;
  String mobilephone;
  String username;
  String email;
  String profile_picture =
      'https://admin.paygear.ir/default-profile-picture.jpg?cache-first';

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
                  child: Text("ویرایش",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ]),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  image: DecorationImage(
                                    image: NetworkImage('${profile_picture}'),
                                    fit: BoxFit.fill,
                                  ))),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: 500,
                            padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                            child: TextField(
                              controller: TextEditingController(text: name),
                              onChanged: (value) {
                                name = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(250, 236, 196, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      topLeft: Radius.circular(25)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Container(
                            width: 150,
                            padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                            child: TextField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(241, 201, 82, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                ),
                                hintText: "نام و نام خانوادگی",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: 500,
                            padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                            child: TextField(
                              controller: TextEditingController(text: username),
                              onChanged: (value) {
                                username = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(250, 236, 196, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      topLeft: Radius.circular(25)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Container(
                            width: 150,
                            padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                            child: TextField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(241, 201, 82, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                ),
                                hintText: "نام کاربری",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: 500,
                            padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                            child: TextField(
                              controller:
                                  TextEditingController(text: mobilephone),
                              onChanged: (value) {
                                mobilephone = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(250, 236, 196, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      topLeft: Radius.circular(25)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Container(
                            width: 150,
                            padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                            child: TextField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(241, 201, 82, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                ),
                                hintText: "شماره موبایل",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: 500,
                            padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                            child: TextField(
                              enableInteractiveSelection: false,
                              controller: textEditingController,
                              onTap: () {
                                FocusScope.of(context).requestFocus(
                                    new FocusNode()); // to prevent opening default keyboard
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return persianDatePicker;
                                    });
                              },
                              onChanged: (value) {
                                print("value");
                                print(value);
                                birthDate = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(250, 236, 196, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      topLeft: Radius.circular(25)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Container(
                            width: 150,
                            padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                            child: TextField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(241, 201, 82, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                ),
                                hintText: "تاریخ تولد",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: 500,
                            padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                            child: TextField(
                              controller: TextEditingController(text: email),
                              onChanged: (value) {
                                email = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(250, 236, 196, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      topLeft: Radius.circular(25)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Container(
                            width: 150,
                            padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                            child: TextField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(241, 201, 82, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                ),
                                hintText: "ایمیل",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                              width: 500,
                              padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                              child: InputDecorator(
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    fillColor:
                                        Color.fromRGBO(250, 236, 196, 10),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(25),
                                          topLeft: Radius.circular(25)),
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
                                                  alignment:
                                                      Alignment.centerRight,
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
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Container(
                            width: 150,
                            padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                            child: TextField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(241, 201, 82, 10),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                ),
                                hintText: "استان",
                              ),
                            ),
                          ),
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
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: InkWell(
                            onTap: _editProfile,
                            child: Image.asset(
                              "assets/images/success.png",
                              height: 50,
                              width: 50,
                            ),
                          )),
                      Container(
                        child: Text(
                          "تایید",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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

  void _home() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void _getdata() async {
    final getDataUser = await User_Id();
    final decode = jsonDecode(getDataUser);
    final userId = decode['user_id'];
    var headers = await Headers();
    await http
        .get(Apis().baseUrl + 'users/v3/accounts/$userId?mod=0',
            headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var data = resp.body;
        var decode = jsonDecode(data);
        setState(() {
          name = decode['name'];
          mobilephone = decode['mobile_phone'];
          idProvince = decode['province_id'];
          username = decode['username'];
          email = decode['email'];
          BirthDatee = decode['birth_date'];
          Birth = Date().Greg(BirthDatee);

          if (decode['profile_picture'] != "") {
            profile_picture =
                'https://api.paygear.ir/files/v3/${decode['profile_picture']}?cache-first';
          }
        });
      }
    });
  }

  void _editProfile() async {
    // if (natinal_code != null && name != null ) {
    this._showSnackBarWait();
    final getDataUser = await User_Id();
    final decode = jsonDecode(getDataUser);
    final userId = decode['user_id'];
    var headers = await Headers();

    Map data = {
      'birth_date': birthDate,
      'account_type': 2,
      'province_id': idProvince,
      "name": name,
      "username": username,
      "mobile_phone": mobilephone,
      "email": email,
    };

    String body = json.encode(data);
    http
        .put(Apis().baseUrl + 'users/v3/accounts/${userId}',
            body: body, headers: headers)
        .then((resp) {
      if (resp.statusCode == 204) {
        this._showSnackBar(context);
      } else {
        this._showSnackBarErorr(context);
      }
    });


  }

  void _showSnackBarErorr(BuildContext context) {
    Navigator.pop(context,false);
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
}
