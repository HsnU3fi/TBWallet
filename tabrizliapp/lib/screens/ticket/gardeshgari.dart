import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'dart:ui' as ui;
import 'dart:html';



class Gardeshgari extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidget();
  }
}
class MyWidget extends State<Gardeshgari> {
  IFrameElement _iframeElement=IFrameElement();

  @override
  initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      this._loader();
    });

    _iframeElement.src= 'https://rezervinno.ir/tabrizli';
    _iframeElement.id= 'iframe';

    // ..id = 'iframe';
    ui.platformViewRegistry.registerViewFactory(
      'I',
          (int viewId) => _iframeElement,
    );
    print(_iframeElement);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("رزوینو",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black))
            ],
          ),
          toolbarHeight: 80,
          backgroundColor: Color.fromRGBO(252, 246, 225, 10),

          leading: IconButton(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        body:Container(
          child:HtmlElementView(
            // key: UniqueKey(),
            viewType: 'I',
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

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pop(context, false);
    });
  }

  void _back() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home();
    }));
  }


//baraye webview kardan dar flutter web niyaz shod az html element view estefade konam chon dependency khasi baaraye in kar nadasht


}




