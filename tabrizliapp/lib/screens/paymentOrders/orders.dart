import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/setting/setting.dart';

import 'orderdetails.dart';

class Orders extends StatefulWidget {
  final String merchantId;

  Orders({Key key, @required this.merchantId}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List OrderList = [];
  List OrdersList = [];
  Object OrderListIndex;
  List OrderName = [];
  List OrderAmount = [];
  List OrderType = [];
  List Image = [];
  List IconOrders = [];
  List DateOrder = [];
  bool isLoading = false;
  ScrollController _sc = new ScrollController();
  static int page = 1;

  // int index=1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders(page);
    Future.delayed(Duration.zero, () {
      this._loader();
    });
  }

  void _setting() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Setting();
    }));
  }

  @override
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
        child: ListView.separated(
          controller: _sc,
          padding: const EdgeInsets.all(8),
          itemCount: OrderList.length + 1,
          itemBuilder: (BuildContext context, index) {
            if (index == OrderList.length) {
              return _buildProgressIndicator();
            } else {
              return Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(250, 236, 196, 10),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 100,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            OrderListIndex = OrderList[index];
                          });
                          _sendDataToOrdersDetails(context);
                        },
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 0, 0),
                                          child: Center(
                                            child: Text(
                                              '${OrderAmount[index]}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 0, 0),
                                          child: Center(
                                            child: Text(
                                              '﷼',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Center(
                                        child: Text(
                                          '${OrderType[index]}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Center(
                                        child: Text(
                                          '${OrderName[index]}',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  140, 83, 62, 10),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Center(
                                        child: Text(
                                          '${DateOrder[index]}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Center(
                                    child: SizedBox(
                                        height: 50,
                                        width: 25,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: ExactAssetImage(
                                                "${IconOrders[index]}"),
                                            fit: BoxFit.fill,
                                          )),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Center(
                                    child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                              image: DecorationImage(
                                                image: ExactAssetImage(
                                                    "${Image[index]}"),
                                                fit: BoxFit.fill,
                                              )),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
            }
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _home() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }

  void getOrders(int page) async {
    print("salam salam");
    print(widget.merchantId);
    if (widget.merchantId == null) {
      var headers = await Headers();
      final getDataUser = await User_Id();
      final decode = jsonDecode(getDataUser);
      final Id = decode['user_id'];
      await http
          .get(
              Apis().baseUrl +
                  'payment/v3/accounts/${Id}/orders?mode=0&pre_orders=true&per_page=99999&page=${page}',
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 200) {
          var data = resp.body;
          var decode = jsonDecode(data);
            for (var a in decode["result"]) {
              if (a['order_type'] != 8) {
                print("sep");
                print(a);
                if (a["order_type"] == 0 && a['receiver']['_id'] != Id) {
                  OrderType.add(':پرداخت به');
                  Image.add("assets/images/default-profile-picture.jpg");
                  IconOrders.add("assets/images/payicon.png");
                  var name = a['receiver']['name'];
                  OrderName.add(name);
                  var amount = a['amount'];
                  OrderAmount.add(amount);
                  var Datee = a['created_at_timestamp'];
                  var GDate = new DateTime.fromMillisecondsSinceEpoch(Datee);
                  var StrGDate = GDate.toString();
                  DateOrder.add(Date().Greg(StrGDate));
                }
                if (a["order_type"] == 0 && a['receiver']['_id'] == Id) {
                  OrderType.add(':دریافت از');
                  Image.add("assets/images/default-profile-picture.jpg");
                  IconOrders.add("assets/images/resiveicon.png");
                  var name = a['sender']['name'];
                  OrderName.add(name);
                  var amount = a['amount'];
                  OrderAmount.add(amount);
                  var Datee = a['created_at_timestamp'];
                  var GDate = new DateTime.fromMillisecondsSinceEpoch(Datee);
                  var StrGDate = GDate.toString();
                  DateOrder.add(Date().Greg(StrGDate));
                }
                if (a['order_type'] == 2) {
                  OrderType.add(':شارژ کیف پول');
                  Image.add("assets/images/tab_riz.png");
                  IconOrders.add("assets/images/resiveicon.png");
                  var name = a['receiver']['name'];
                  OrderName.add(name);
                  var amount = a['amount'];
                  OrderAmount.add(amount);
                  var Datee = a['created_at_timestamp'];
                  var GDate = new DateTime.fromMillisecondsSinceEpoch(Datee);
                  var StrGDate = GDate.toString();
                  DateOrder.add(Date().Greg(StrGDate));
                }
                if (a['order_type'] == 5) {
                  OrderType.add(':شارژ کیف پول');
                  Image.add("assets/images/tab_riz.png");
                  IconOrders.add("assets/images/resiveicon.png");
                  var name = a['receiver']['name'];
                  OrderName.add(name);
                  var amount = a['amount'];
                  OrderAmount.add(amount);
                  var Datee = a['created_at_timestamp'];
                  var GDate = new DateTime.fromMillisecondsSinceEpoch(Datee);
                  var StrGDate = GDate.toString();
                  DateOrder.add(Date().Greg(StrGDate));
                }
                if (a['order_type'] == 11) {
                  OrderType.add(':برداشت از کیف');
                  Image.add("assets/images/tab_riz.png");
                  IconOrders.add("assets/images/resiveicon.png");
                  var name = "انتقال به پایا";
                  OrderName.add(name);
                  var amount = a['amount'];
                  OrderAmount.add(amount);
                  var Datee = a['created_at_timestamp'];
                  var GDate = new DateTime.fromMillisecondsSinceEpoch(Datee);
                  var StrGDate = GDate.toString();
                  DateOrder.add(Date().Greg(StrGDate));
                }
              }
            }
          setState(() {
            OrderList = decode["result"];
            Navigator.pop(context, false);
          });
        }
      });
    }
    if (widget.merchantId != null) {
      var headers = await Headers();

      final Id = widget.merchantId;
      await http
          .get(
              Apis().baseUrl +
                  'payment/v3/accounts/${Id}/orders?mode=0&pre_orders=true&per_page=99999&page=${page}',
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 200) {
          var data = resp.body;
          var decode = jsonDecode(data);
          for (var a in decode["result"]) {
            if (a['order_type'] != 8) {
              print("sep");
              print(a);
              if (a["order_type"] == 0 && a['receiver']['_id'] != Id) {
                OrderType.add(':پرداخت به');
                Image.add("assets/images/default-profile-picture.jpg");
                IconOrders.add("assets/images/payicon.png");
                var name = a['receiver']['name'];
                OrderName.add(name);
                var amount = a['amount'];
                OrderAmount.add(amount);
                var Datee = a['created_at_timestamp'];
                var GDate = new DateTime.fromMillisecondsSinceEpoch(Datee);
                var StrGDate = GDate.toString();
                DateOrder.add(Date().Greg(StrGDate));
              }
              if (a["order_type"] == 0 && a['receiver']['_id'] == Id) {
                OrderType.add(':دریافت از');
                Image.add("assets/images/default-profile-picture.jpg");
                IconOrders.add("assets/images/resiveicon.png");
                var name = a['sender']['name'];
                OrderName.add(name);
                var amount = a['amount'];
                OrderAmount.add(amount);
                var Datee = a['created_at_timestamp'];
                var GDate = new DateTime.fromMillisecondsSinceEpoch(Datee);
                var StrGDate = GDate.toString();
                DateOrder.add(Date().Greg(StrGDate));
              }
              if (a['order_type'] == 2) {
                OrderType.add(':شارژ کیف پول');
                Image.add("assets/images/tab_riz.png");
                IconOrders.add("assets/images/resiveicon.png");
                var name = a['receiver']['name'];
                OrderName.add(name);
                var amount = a['amount'];
                OrderAmount.add(amount);
                var Datee = a['created_at_timestamp'];
                var GDate = new DateTime.fromMillisecondsSinceEpoch(Datee);
                var StrGDate = GDate.toString();
                DateOrder.add(Date().Greg(StrGDate));
              }
              if (a['order_type'] == 5) {
                OrderType.add(':شارژ کیف پول');
                Image.add("assets/images/tab_riz.png");
                IconOrders.add("assets/images/resiveicon.png");
                var name = a['receiver']['name'];
                OrderName.add(name);
                var amount = a['amount'];
                OrderAmount.add(amount);
                var Datee = a['created_at_timestamp'];
                var GDate = new DateTime.fromMillisecondsSinceEpoch(Datee);
                var StrGDate = GDate.toString();
                DateOrder.add(Date().Greg(StrGDate));
              }
              if (a['order_type'] == 11) {
                OrderType.add(':برداشت از کیف');
                Image.add("assets/images/tab_riz.png");
                IconOrders.add("assets/images/resiveicon.png");
                var name = "انتقال به پایا";
                OrderName.add(name);
                var amount = a['amount'];
                OrderAmount.add(amount);
                var Datee = a['created_at_timestamp'];
                var GDate = new DateTime.fromMillisecondsSinceEpoch(Datee);
                var StrGDate = GDate.toString();
                DateOrder.add(Date().Greg(StrGDate));
              }
            }

          }

          setState(() {
            OrderList = decode["result"];
            Navigator.pop(context, false);
          });
        }
      });
    }
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

  void _sendDataToOrdersDetails(BuildContext context) {
    var data = jsonEncode(OrderListIndex);
    String textToSend = data;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderDetails(
            dataOrders: textToSend,
          ),
        ));
  }
}
