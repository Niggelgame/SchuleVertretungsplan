import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
    ));
    return Scaffold(
      body: Container(
        color: Colors.white,
          child: Center(
            child: Image(image: AssetImage("assets/icon.jpg")),
          ),
      ),
    );
  }
}