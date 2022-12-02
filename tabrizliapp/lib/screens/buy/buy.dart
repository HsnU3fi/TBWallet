import'package:flutter/material.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'dart:js' as js;
import 'befrosh.dart';

class Buy extends StatefulWidget {
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(252, 246, 225, 10),
        actions: [
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              icon: Icon(Icons.home, size: 30, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
          ),
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
                child: Text("خرید و خدمات",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ]),
            Container(
              child: FittedBox(
                child: Image.asset('assets/images/imagehome.png'),
              ),
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Colors.black)),
                            color: Color.fromRGBO(250, 236, 196, 10),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Image.asset('assets/images/befrosh_buy.png'),
                            onPressed:(){
                              js.context.callMethod(
                                  'open', ['https://www.befroush.net/paygear/landing']);
                            }
                            ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "بفروش",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
  void _befrosh() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Befrosh();
    }));
  }

}

