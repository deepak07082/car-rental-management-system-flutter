import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:car_rendal_app/Screens/Login.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../main.dart';
import 'InterNetChecker.dart';

class SpleashScreen extends StatefulWidget {
  @override
  _SpleashScreenState createState() => _SpleashScreenState();
}

class _SpleashScreenState extends State<SpleashScreen> {
  @override
  void initState() {
    Timer(
        Duration(
          seconds: 10,
        ),
        nextpge);
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  nextpge() {
    Get.to((InternetChecker()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: VStack(
          [
            SlideInRight(
              // duration: Duration(seconds: 1),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FlareActor(
                    "Assets/Car_Spleash.flr",
                    animation: "start",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SlideInLeft(
                child: "DD Car Rendal"
                    .text
                    .extraBold
                    .extraBlack
                    .italic
                    .blue600
                    .size(25)
                    .lineHeight(3)
                    .makeCentered()),
          ],
        ),
      ),
    );
  }
}

class StatusChecker extends StatefulWidget {
  StatusChecker({Key key}) : super(key: key);

  @override
  _StatusCheckerState createState() => _StatusCheckerState();
}

class _StatusCheckerState extends State<StatusChecker> {
  String userid, user;
  bool onboard, onboard1;
  Future<dynamic> getUserID() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    userid = myPrefs.getString("userid");
    setState(() {
      user = userid;
      print("$user-$userid");
    });
    print(userid);
  }

  Future<dynamic> onboardingpref() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool("onboardingopened", false);
    onboard = myPrefs.getBool("onboardingopened");
    setState(() {
      onboard1 = (onboard == null || onboard == false) ? false : true;
      print("$onboard1-$onboard");
    });
    print(onboard1);
  }

  @override
  void initState() {
    getUserID();
    onboardingpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData == null) {
            return Login();
          } else {
            return ((userid == null) ? Login() : BottomNavBar());
          }
        },
      ),
    );
  }

 
}
