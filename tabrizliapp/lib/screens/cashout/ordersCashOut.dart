import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/setting/setting.dart';

class OrdersCashOut extends StatefulWidget {
  final String merchantId;

  OrdersCashOut({Key key, @required this.merchantId}) : super(key: key);

  @override
  _OrdersCashOutState createState() => _OrdersCashOutState();
}

class _OrdersCashOutState extends State<OrdersCashOut> {
  List OrderList = [];
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
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                    child: Center(
                                      child: Text(
                                        '${OrderList[index]['amount']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
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
                                    'حساب تبریزلی',
                                    style: TextStyle(
                                        color: Color.fromRGBO(140, 83, 62, 10),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Center(
                              child: SizedBox(
                                  height: 43,
                                  width: 28,
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
                                  height: 70,
                                  width: 70,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        image: DecorationImage(
                                          image: ExactAssetImage(
                                              "assets/images/default-profile-picture.jpg"),
                                          fit: BoxFit.fill,
                                        )),
                                  )),
                            ),
                          )
                        ],
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
    if (widget.merchantId == null) {
      var headers = await Headers();
      final getDataUser = await User_Id();
      final decode = jsonDecode(getDataUser);
      final userId = decode['user_id'];
      await http
          .get(
              'https://walletboom.izbank.ir/samsson/cashout-manager/v3/request?id=${userId}&page=${page}&per_page=999999',
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 200) {
          var data = resp.body;
          var decode = jsonDecode(data);
          print(decode['result']);
          print('decode');

          if (decode['result'] == []) {
            this._showSnackBarResaultNull(context);
          }
          print("sag to in zndegi");
          print(decode);
          for (var a in decode["result"]) {
            if (a['state'] == 30) {
              OrderType.add('در انتظار تایید درخواست');
              IconOrders.add("assets/images/ic_payment_pending.png");
            }
            if (a['state'] == 40 | 70) {
              OrderType.add('در انتظار تسویه حساب');
              IconOrders.add("assets/images/ic_payment_pending.png");
            }

            if (a['state'] == 90) {
              OrderType.add('در انتظار دریافت تایید از بانک');
              IconOrders.add("assets/images/ic_payment_pending.png");
            }
            if (a['state'] == 60) {
              OrderType.add('برگشت به کیف پول');
              IconOrders.add("assets/images/revers.png");
            }
            if (a['state'] == 100) {
              OrderType.add('تسویه');
              IconOrders.add("assets/images/revers.png");
            }
            if (a["state"] != 10 | 20 | 50 | 80) {
              OrderType.add('نامشخص');
              IconOrders.add("assets/images/ic_payment_pending.png");
            }
            var Datee = a['created_at'];
            DateOrder.add(Date().Greg(Datee));
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
      final userId = widget.merchantId;
      print(userId);
      await http
          .get(
              'https://walletboom.izbank.ir/samsson/cashout-manager/v3/request?id=${userId}&page=${page}&per_page=999999',
              headers: headers)
          .then((resp) {
        if (resp.statusCode == 200) {
          var data = resp.body;
          var decode = jsonDecode(data);
          print('decode');
          print(decode);
          if (decode["result"] == []) {
            print("sasasasasasa");

            this._showSnackBarResaultNull(context);
          }

          for (var a in decode["result"]) {
            if (a['state'] == 30) {
              OrderType.add('در انتظار تایید درخواست');
              IconOrders.add("assets/images/ic_payment_pending.png");
            }
            if (a['state'] == 40) {
              OrderType.add('در انتظار تسویه حساب');
              IconOrders.add("assets/images/ic_payment_pending.png");
            }
            if (a['state'] == 70) {
              OrderType.add('در انتظار تسویه حساب');
              IconOrders.add("assets/images/ic_payment_pending.png");
            }

            if (a['state'] == 90) {
              OrderType.add('در انتظار دریافت تایید از بانک');
              IconOrders.add("assets/images/ic_payment_pending.png");
            }
            if (a['state'] == 60) {
              OrderType.add('برگشت به کیف پول');
              IconOrders.add("assets/images/revers.png");
            }
            if (a['state'] == 100) {
              OrderType.add('تسویه');
              IconOrders.add("assets/images/revers.png");
            }
            if (a["state"] == 10 | 20 | 50 | 80) {
              OrderType.add('نامشخص');
              IconOrders.add("assets/images/ic_payment_pending.png");
            }
            var Datee = a['created_at'];
            DateOrder.add(Date().Greg(Datee));
          }

          setState(() {
            OrderList = decode["result"];
            Navigator.pop(context, false);
          });
        }
      }).catchError((e) => {
                Navigator.pop(context, false),
                this._showSnackBarErorr(context)
              });
    }
  }

  void _showSnackBarResaultNull(BuildContext context) {
    // Navigator.pop(context, false);
    final snackBar = SnackBar(
      content: Text('شما تراکنشی ندارید',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      width: 300,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
}
