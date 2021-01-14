import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

class Settings extends StatefulWidget {
  static const routeName = '/SettingsPage_3';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String userid, user;
  bool enable = false;
  Future<dynamic> getUserID() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    userid = myPrefs.getString("userid");
    setState(() {
      user = userid;
      print("$user-$userid");
    });
    print(userid);
  }

  getDarkValue() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    dark = myPrefs.getBool("isdarktheme");
    setState(() {
      enable = dark;
    });
  }

  bool dark;
  @override
  void initState() {
    getUserID();
    getDarkValue();
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  darkTheme(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              var userDocument = snapshot.data;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    SlideInUp(
                      child: Card(
                        elevation: 0.5,
                        margin: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SlideInLeft(
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            userDocument['photourl']),
                                        radius: 22.0,
                                      ),
                                    ),
                                  ),
                                  SlideInRight(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: "${userDocument['username']}"
                                          .text
                                          .semiBold
                                          .make()
                                          .shimmer(
                                            primaryColor: Colors.blue[600],
                                            secondaryColor: Colors.cyan,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildDivider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text('Show Profile'),
                              ),
                            ).onInkTap(() {})
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ZoomIn(
                      child: Text(
                        "General Settings".toUpperCase(),
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SlideInLeft(
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 0,
                        ),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Colors.lightGreen,
                              ),
                              title: Text("Change E-Mail"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change password
                              },
                            ),
                            _buildDivider(),
                            ListTile(
                              leading: Icon(
                                Icons.phone,
                                color: Colors.lightGreen,
                              ),
                              title: Text("Change Phone Number"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change location
                              },
                            ),
                            _buildDivider(),
                            ListTile(
                              leading: Icon(
                                Icons.lock_outline,
                                color: Colors.lightGreen,
                              ),
                              title: Text("Change Password"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change password
                              },
                            ),
                            _buildDivider(),
                            ListTile(
                              leading: Icon(
                                Icons.language,
                                color: Colors.lightGreen,
                              ),
                              title: Text("Change Language"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change language
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SlideInLeft(
                      child: Text(
                        "Notification Settings".toUpperCase(),
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SlideInLeft(
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 0,
                        ),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child: Text("Theme"),
                              onPressed: () {
                                setState(() {
                                  if (enable == true) {
                                    enable = false;
                                    Get.changeTheme(ThemeData.light());
                                    darkTheme("isdarktheme", false);
                                  } else {
                                    enable = false;
                                    Get.changeTheme(ThemeData.dark());
                                    darkTheme("isdarktheme", true);
                                  }
                                });
                              },
                            ),
                            Container(
                              child: SwitchListTile(
                                activeColor: Colors.lightGreen,
                                value: true,
                                title: Text("Theme"),
                                onChanged: (val) {},
                              ),
                            ),
                            _buildDivider(),
                            SwitchListTile(
                              activeColor: Colors.lightGreen,
                              value: false,
                              title: Text("Notifications"),
                              onChanged: (val) {},
                            ),
                            _buildDivider(),
                            SwitchListTile(
                              activeColor: Colors.lightGreen,
                              value: false,
                              title: Text("Alerts"),
                              onChanged: (val) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    SlideInRight(
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 0,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: SlideInLeft(child: Text("Logout")),
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.remove("userid");

                            await FirebaseAuth.instance.signOut();
                            await googleSignIn.disconnect();
                            Get.to(Login());
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 60.0),
                  ],
                ),
              );
            }));
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}
