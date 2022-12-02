import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tabrizli/screens/home/home.dart';
import 'dart:ui' as ui;
import 'dart:html';


// final Color darkBlue = Color.fromARGB(255, 18, 32, 47);


// class Befrosh extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: IframeDemo(),
//         ),
//       ),
//     );
//   }
// }
class Befrosh extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidget();
  }
}
class MyWidget extends State<Befrosh> {
  IFrameElement _iframeElement=IFrameElement();

  @override
  initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      this._loader();
    });

    // _url = 'https://www.befroush.net/paygear/landing';
    _iframeElement.src= 'https://www.befroush.net/paygear/landing';
    _iframeElement.id= 'iframe';

      // ..id = 'iframe';
    ui.platformViewRegistry.registerViewFactory(
      'l',
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
              Text("نقشه",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black))
            ],
          ),
          toolbarHeight: 80,
          backgroundColor: Color.fromRGBO(252, 246, 225, 10),
          leading: BackButton(
            color: Colors.black,
            onPressed: _back,
          ),
        ),
        body:Container(
          child:HtmlElementView(
            // key: UniqueKey(),
            viewType: 'l',
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

    Future.delayed(Duration(seconds: 7), () {
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




