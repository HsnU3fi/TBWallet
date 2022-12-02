import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html';
import 'package:tabrizli/screens/municipality/Municipality.dart';

class AvarezTabloSenfi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidget();
  }
}

class MyWidget extends State<AvarezTabloSenfi> {
  String _url;
  IFrameElement _iframeElement;

  @override
  initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      this._loader();
    });

    _url = 'https://citizen.tabriz.ir/Home/PayPanel';
    _iframeElement = IFrameElement()
      ..src = _url
      ..id = 'iframe'
      ..style.border = 'none';
    ui.platformViewRegistry.registerViewFactory(
      'AvarezTabloSenfi',
      (int viewId) => _iframeElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("عوارض تابلوهای صنفی",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))
            ],
          ),
          toolbarHeight: 80,
          backgroundColor: Color.fromRGBO(252, 246, 225, 10),
          leading: BackButton(
            color: Colors.black,
            onPressed: _back,
          ),
        ),
        body: Container(
          child: HtmlElementView(
            viewType: 'AvarezTabloSenfi',
          ),
        ));
  }



  _loader() {
    AwesomeDialog(
      dialogType: DialogType.NO_HEADER,
      context: context,
      body: Column(
        children: [
          CircularProgressIndicator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  ".لطفا منتظر بمانید",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    )..show();

    Future.delayed(Duration(seconds: 5), () {
      Navigator.pop(context, false);
    });
  }

  void _back() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Municipality();
    }));
  }
}
