import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata/Sharedpreferenced/SessionManager.dart';
import 'package:wisata/models/onBoardingModel.dart';
import 'package:wisata/ui/LoginScreen.dart';
import 'package:wisata/ui/root.dart';

enum statusLogin { signIn, notSignIn }
class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnBoardingScreen extends StatefulWidget {


  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  statusLogin _loginStatus = statusLogin.notSignIn;
  SharedPreference session=new SharedPreference();

  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getDataPref();
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xff3C8CE7),
                      const Color(0xff00EAFF)
                    ])),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 100,
                child: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      slideIndex = index;
                    });
                  },
                  children: <Widget>[

                    SlideTile(
                      imagePath: mySLides[0].getImageAssetPath(),
                      title: mySLides[0].getTitle(),
                      desc: mySLides[0].getDesc(),
                    ),
                    SlideTile(
                      imagePath: mySLides[1].getImageAssetPath(),
                      title: mySLides[1].getTitle(),
                      desc: mySLides[1].getDesc(),
                    ),
                    SlideTile(
                      imagePath: mySLides[2].getImageAssetPath(),
                      title: mySLides[2].getTitle(),
                      desc: mySLides[2].getDesc(),
                    )
                  ],
                ),
              ),
              bottomSheet: slideIndex != 2 ? Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        controller.animateToPage(
                            2, duration: Duration(milliseconds: 400),
                            curve: Curves.linear);
                      },
                      splashColor: Colors.blue[50],
                      child: Text(
                        "SKIP",
                        style: TextStyle(color: Color(0xFF0074E4),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          for (int i = 0; i < 3; i++) i == slideIndex
                              ? _buildPageIndicator(true)
                              : _buildPageIndicator(false),
                        ],),
                    ),
                    FlatButton(
                      onPressed: () {
                        print("this is slideIndex: $slideIndex");
                        controller.animateToPage(slideIndex + 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      splashColor: Colors.blue[50],
                      child: Text(
                        "NEXT",
                        style: TextStyle(color: Color(0xFF0074E4),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ) :
              InkWell(
                onTap: () {
                  //print("Get Started Now");
                  session.onBoardingof();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Root()),
                    ModalRoute.withName('/OnBoardingScreen'),
                  );
                },
                child: Container(

                  height: Platform.isIOS ? 70 : 60,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text(
                    "GET STARTED NOW",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        );
        break;
      case statusLogin.signIn:
        return Root();
        break;
    }
  }
  getDataPref() async {

    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    setState(() {
      int nvalue = sharedPreferences.getInt("shared");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
    });

  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child:Image.asset(imagePath),
          ),

          Text(title, textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
          ),),
          SizedBox(
            height: 20,
          ),
          Text(desc, textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14))
        ],
      ),
    );
  }

}