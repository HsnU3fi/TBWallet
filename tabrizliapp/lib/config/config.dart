library jwt_decoder;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shamsi_date/shamsi_date.dart';

class JwtDecoder {
  static Map<String, dynamic> decode(String token) {
    try {
      List<String> splitToken = token.split("."); // Split the token by '.'
      String payloadBase64 = splitToken[1]; // Payload is always the index 1
      // Base64 should be multiple of 4. Normalize the payload before decode it
      String normalizedPayload = base64.normalize(payloadBase64);
      // Decode payload, the result is a String
      String payloadString = utf8.decode(base64.decode(normalizedPayload));
      // Parse the String to a Map<String, dynamic>
      Map<String, dynamic> decodedPayload = jsonDecode(payloadString);

      // Return the decoded payload
      return decodedPayload;
    } catch (error) {
      // If there's an error return null
      return null;
    }
  }
}

Object Headers() async {
  var perf = await SharedPreferences.getInstance();
  var token = perf.getString('token');
  var gettoken = jsonDecode(token);
  var dict = {
    'Content-Type': 'application/json',
    'Authorization': 'bearer $gettoken'
  };
  return dict;
}

class Date {
  Greg(date) {
    print("salam");
    print(date);
    if (date != null) {
      String y = date.substring(0, 4);
      int year = int.parse(y);
      String m = date.substring(5, 7);
      int month = int.parse(m);
      String d = date.substring(8, 10);
      int day = int.parse(d);
      Gregorian G = Gregorian(year, month, day);
      Jalali j = G.toJalali();
      var DateJ = '${j.year}/${j.month}/${j.day}';
      return DateJ;
    }
  }

  persion(date) {
    String y = date.substring(0, 4);
    int year = int.parse(y);
    String m = date.substring(5, 7);
    int month = int.parse(m);
    String d = date.substring(8, 10);
    int day = int.parse(d);
    Jalali j = Jalali(year, month, day);
    Gregorian g = j.toGregorian();
    var DateG = '${g.year}-${g.month}-${g.day}T16:03:08+0330';
    return DateG;
  }
}

User_Id() async {
  var prefs = await SharedPreferences.getInstance();
  var data = prefs.getString('data');
  var decode = jsonDecode(data);
  return decode;
}

class Apis {
  final baseUrl = 'http://api.tabrizliapp.com/izboom/';
  final appId = '59bec3fa0eca810001ceeb86';

  Apis({baseUrl, appId});
}

class SharedPrefi {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final get = json.decode(prefs.getString(key));
    return get;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
