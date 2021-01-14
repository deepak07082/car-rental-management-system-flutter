import 'package:animate_do/animate_do.dart';
import 'package:car_rendal_app/Screens/Aboutus.dart';
import 'package:car_rendal_app/Screens/Home.dart';
import 'package:car_rendal_app/Screens/Settings.dart';
import 'package:car_rendal_app/Screens/Spleash_Screen.dart';
import 'package:car_rendal_app/Screens/TopDeals.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Firebase.initializeApp();
    getDarkValue();
    super.initState();
  }

  getDarkValue() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    dark = myPrefs.getBool("isdarktheme");
    setState(() {
      theme = dark;
    });
  }

  bool dark, theme;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DD Car Rendal',
      theme: ThemeData(
        brightness: (theme == true) ? Brightness.dark : Brightness.light,
        fontFamily: GoogleFonts.notoSerif().fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: SpleashScreen(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

int pos = 0;

class _BottomNavBarState extends State<BottomNavBar> {
  GlobalKey _bottomNavigationKey = GlobalKey();

  darkTheme(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        VxToast.show(context, msg: "Again Press to Exit");
        return Future.value(false);
      }
      return Future.value(true);
    }

    List<Widget> _buildScreens = [
      Home(),
      TopDeals(),
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Vx.randomPrimaryColor,
      ),
      AboutUs(),
      Settings(),
    ];
    return Scaffold(
        bottomNavigationBar: WillPopScope(
          onWillPop: onWillPop,
          child: SlideInDown(
            child: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              height: 50.0,
              items: <Widget>[
                Icon(Icons.home, size: 30, color: Vx.gray900),
                Icon(Icons.list, size: 30, color: Vx.gray900),
                Icon(Icons.compare_arrows, size: 30, color: Vx.gray900),
                Icon(Icons.call_split, size: 30, color: Vx.gray900),
                Icon(Icons.settings, size: 30, color: Vx.gray900),
              ],
              color: Colors.white,
              buttonBackgroundColor: Colors.blueAccent,
              backgroundColor: Colors.white,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (index) {
                setState(() {
                  pos = index;
                });
              },
              letIndexChange: (index) => true,
            ),
          ),
        ),
        body: Container(
          //color: Colors.blueAccent,
          child: _buildScreens[pos],
        ));
  }
}
