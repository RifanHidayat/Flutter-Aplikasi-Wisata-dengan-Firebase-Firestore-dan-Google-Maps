import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata/ui/ResideDrawer.dart';
import 'package:wisata/ui/LoginScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Travel App",
      color: Colors.green,
      debugShowCheckedModeBanner: false,
      home: Root(),
    );
  }
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int nvalue;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, snapshot) {
        if (nvalue==1) {

          return ResideDrawer(
            posisi: "1",
            tiitle: "Home",
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }
  getDataPref() async {
    SharedPreferences sharedPreferences = await
    SharedPreferences.getInstance();
    setState(() {
      nvalue = sharedPreferences.getInt("value");
      //_loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;


    });
  }
  @override
  void initState() {
  getDataPref();
    // TODO: implement initState
    super.initState();
  }
}
