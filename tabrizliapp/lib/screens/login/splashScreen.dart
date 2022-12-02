import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabrizli/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:tabrizli/screens/home/home.dart';
import 'package:tabrizli/screens/login/login.dart';
import 'package:tabrizli/screens/users/users.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handelspalsh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromRGBO(242, 190, 34, 10),
      child: Center(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 360,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Image.asset(
                'assets/images/shahdari.png',
                height: 100,
              ),
            ),
            Text(
              "Tabrizli",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              "loading...",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          SizedBox(
            height:10 ,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)
                  ),
                  height: 35,
                  width: 35,
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    ));
  }

  void handelspalsh() async {
    await Future.delayed(Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();

    final gettoken = prefs.getString('datatoken');
    if (gettoken != null) {
      final decode = jsonDecode(gettoken);
      final access_token = decode['x-access-token'];
      SharedPrefi().save('token', access_token);

      var ref_token = decode['x-refresh-token'];

      var Datenow = DateTime.now().millisecondsSinceEpoch;
      var expiresdate = JwtDecoder.decode(access_token)['exp'];

      var d = Datenow.toString().substring(0, 10);
      var Date = int.parse(d);

      if (expiresdate <= Date) {
        Map data = {"refresh_token": ref_token, "appid": Apis().appId};
        String body = jsonEncode(data);

        http.post(Apis().baseUrl + 'users/v3/auth/refresh',
            body: body, headers: {}).then((resp) {
          if (resp.statusCode == 200) {
            SharedPrefi().remove('datatoken');
            SharedPrefi().remove('data');

            SharedPrefi().save('data', resp.body);
            SharedPrefi().save('datatoken', resp.headers);
          }
        });
      }
    }

    if (gettoken == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }

    if (gettoken != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home(),fullscreenDialog: true));
    }
  }
}
