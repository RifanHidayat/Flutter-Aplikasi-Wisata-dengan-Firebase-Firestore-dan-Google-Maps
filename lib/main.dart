import 'package:flutter/material.dart';
import 'package:wisata/Route/locator.dart';
import 'package:wisata/ui/SplassScreen.dart';


void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Travel App",
        color: Colors.red[300],
      debugShowCheckedModeBanner: false,
      home:  SplassScreen()
    );
  }
}
