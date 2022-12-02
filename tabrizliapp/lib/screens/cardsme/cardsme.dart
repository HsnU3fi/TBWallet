import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/newaddcard/newaddcard.dart';
import 'package:tabrizli/screens/setting/setting.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CardsMe extends StatefulWidget {
  @override
  _CardsMeState createState() => _CardsMeState();
}

class _CardsMeState extends State<CardsMe> {
  void _setting() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Setting();
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getcard();
  }

  Future<Null> reflist() async {
    await Future.delayed(Duration(seconds: 2));
  }

  // List<AssetImage> items;
  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color.fromRGBO(252, 246, 225, 10),
          actions: [
            IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                icon: Icon(Icons.home, size: 30, color: Colors.black),
                onPressed: _home
            ),
            IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                icon: Icon(Icons.settings,
                    size: 30, color: Color.fromRGBO(140, 83, 62, 10)),
                onPressed: _setting),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: reflist,
          child: Container(
            color: Color.fromRGBO(252, 246, 225, 10),
            child: ListView(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                        child: Text("کارت های من",
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
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
                      child: InkWell(
                        onTap: _newcard,
                        child: Image.asset(
                          'assets/images/addcard.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: CarouselSlider(
                    items: dataList
                        .map((item) => SizedBox(
                            width: 400,
                            height: 200,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.8),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://api.paygear.ir/files/v3/${item['background_image']}?cache-first'),
                                    fit: BoxFit.fill,
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${item['card_number']}',
                                    style: TextStyle(
                                        backgroundColor: Colors.grey,
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'موجودی:${item['balance']}ریال',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )))
                        .toList(),
                    options: CarouselOptions(
                      height: 250,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 250),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _home() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }

  void _newcard() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewAddCard();
    }));
  }

  void _getcard() async {
    final prefs = await SharedPreferences.getInstance();
    final card = prefs.getString('getcard');
    var decode = jsonDecode(card);
    var decode2 = jsonDecode(decode);
    setState(() {
      dataList = decode2;
    });
    print(dataList);
  }

  void showLoadingIndicator([String text]) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.black87,
            ));
      },
    );
  }
}
