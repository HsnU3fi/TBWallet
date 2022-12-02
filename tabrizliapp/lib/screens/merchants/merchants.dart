import 'dart:convert';
import 'dart:html';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tabrizli/config/config.dart';
import 'package:tabrizli/screens/wallet/wallet.dart';

class Merchants extends StatefulWidget {
  @override
  _MerchantsState createState() => _MerchantsState();
}

class _MerchantsState extends State<Merchants> {
  List MerchantsList = [];
  List Image = [];
  List role = [];
  String merchantId;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getmerchants();
    Future.delayed(Duration.zero, () {
      this._loader();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(252, 246, 225, 10),
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Color.fromRGBO(252, 246, 225, 10),
        child: ListView.separated(
          // controller: _sc,
          padding: const EdgeInsets.all(8),
          itemCount: MerchantsList.length + 1,
          itemBuilder: (BuildContext context, index) {
            if (index == MerchantsList.length) {
              return _buildProgressIndicator();
            } else {
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        merchantId = MerchantsList[index]["_id"];
                      });
                      _sendDataToWallet(context);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 236, 196, 10),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 100,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 10, 0),
                                          child: Center(
                                            child: SizedBox(
                                                height: 40,
                                                width: 40,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                    image: ExactAssetImage(
                                                        "${Image[index]}"),
                                                    fit: BoxFit.fill,
                                                  )),
                                                )),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 20, 5, 0),
                                              child: Center(
                                                child: Text(
                                                  '${MerchantsList[index]["name"]}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      1, 1, 10, 1),
                                                  child: Text(
                                                    '${role[index]}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                  )
                ],
              );
            }
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }

  void _getmerchants() async {
    var headers = await Headers();
    await http
        .get(Apis().baseUrl + 'users/v3/merchants?per_page=200&page=1',
            headers: headers)
        .then((resp) {
      if (resp.statusCode == 200) {
        var data = resp.body;
        var decode = jsonDecode(data);
        print(decode);
        var merchants = decode['merchants'];
        for (var item in merchants) {
          if (item['account_type'] == 0 && item['business_type'] == 2) {
            Image.add('assets/images/taxi.png');
          }
          if (item['account_type'] == 0 && item['business_type'] == 0) {
            Image.add('assets/images/merchant.png');
          }
          item['users'][0]['role'] = 'admin';
          role.add("ادمین");
        }

        setState(() {
          Navigator.pop(context, false);
          print(decode['merchants']);
          print(decode['merchants'].runtimeType);
          MerchantsList = decode['merchants'];
          print(MerchantsList);
          print(MerchantsList.runtimeType);
          print(MerchantsList.length);
        });
      }
    });
  }

  void _sendDataToWallet(BuildContext context) {
    String textToSend = merchantId;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Wallet(
            merchantId: textToSend,
          ),
        ));
  }

  void _loader() {
    // Navigator.pop(context, false);
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
}
