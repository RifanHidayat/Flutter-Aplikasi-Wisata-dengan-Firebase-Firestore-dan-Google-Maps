import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata/ui/onBoardingScreen.dart';
import 'package:wisata/ui/root.dart';

class SplassScreen extends StatefulWidget {
  @override
  _SplassScreenState createState() => _SplassScreenState();
}

class _SplassScreenState extends State<SplassScreen> {
  int nvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/logo.png",
                      width: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Travel App",
                      style: TextStyle(
                          fontSize: 50.0,
                          fontFamily: "Lovely",
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: missing_return
  Future<Timer> starTme() async {

      return Timer(Duration(seconds: 6), OnDone);

  }

  Void OnDone() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      transitionDuration: Duration(seconds: 1),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          OnBoarding(),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          ScaleTransition(
        alignment: Alignment.topLeft,
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.fastLinearToSlowEaseIn,
          ),
        ),
        child: child,
      ),
    ));
  }


  @override
  void initState() {

    starTme();
    super.initState();
  }
}
