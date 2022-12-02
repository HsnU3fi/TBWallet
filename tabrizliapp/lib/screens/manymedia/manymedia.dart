import 'package:flutter/material.dart';
import 'package:tabrizli/screens/municipality/Municipality.dart';
import 'dart:js' as js;
import 'package:tabrizli/screens/municipality/shahriyar.dart';

class Manymedia extends StatefulWidget {
  @override
  _ManymediaState createState() => _ManymediaState();
}

class _ManymediaState extends State<Manymedia> {
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
                child: Text("شهریار نیوز",
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
                            child: Image.asset('assets/images/shahriyar.png'),
                            onPressed: () {
                              js.context.callMethod('open',
                                  ['http://www.shahryarnews.ir/']);
                            }),
                      ),
                    ),
                    Center(
                      child: Text(
                        "شهریار نیوز",
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

  void _back() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Municipality();
    }));
  }
// void _shahriyar() async {
//   await Navigator.push(context, MaterialPageRoute(builder: (context) {
//     return Shahriyar();
//   }));
// }
}
