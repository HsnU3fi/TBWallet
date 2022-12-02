import 'package:flutter/material.dart';
import 'package:tabrizli/screens/login/splashScreen.dart';

void main() {
  runApp(
      MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'IranSans'),
      home: SplashScreen(),
    ),
  );
}
