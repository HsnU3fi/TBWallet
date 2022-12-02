import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html';
import 'package:tabrizli/screens/municipality/Municipality.dart';





class Amvat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidget();
  }
}
class MyWidget extends State<Amvat> {
  String _url;
  IFrameElement _iframeElement;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      this._loader();
    });

    _url = 'http://185.178.220.91/amvat';
    _iframeElement = IFrameElement()
      ..src = _url
      ..id = 'iframe';
    ui.platformViewRegistry.registerViewFactory(
      'Amvat',
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
              Text("جستجوی متوفی",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black))
            ],
          ),
          toolbarHeight: 80,
          backgroundColor: Color.fromRGBO(252, 246, 225, 10),
            leading: BackButton(
              color: Colors.black,
              onPressed:_back,
            ),
        ),
        body:   Container(
          child:  HtmlElementView(
            viewType: 'Amvat',
          ),
        )
    );
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




