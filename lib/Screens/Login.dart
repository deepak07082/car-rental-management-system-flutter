import 'package:animate_do/animate_do.dart';
import 'package:car_rendal_app/Widgets/BouncingButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    Firebase.initializeApp();
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  final firestoreInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
 
  Future<User> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      SharedPreferences myPrefs = await SharedPreferences.getInstance();
      myPrefs.setString("userid", user.uid);

      firestoreInstance.collection("users").doc(user.uid).set({
        "username": user.displayName,
        "photourl": user.photoURL,
        "email": user.email,
        "Balance": "0",
        "img":
            "https://firebasestorage.googleapis.com/v0/b/car-rendal-app.appspot.com/o/Land-Rover-Range-Rover.jpg?alt=media&token=f725ce01-9df3-4d34-9ebb-4c7b32e0c7ee",
        "model": "E-Series",
        "name": "Land Rover",
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return BottomNavBar();
          },
        ),
      );
      return user;
    }

    return null;
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SlideInUp(
                  child: "DD CAR RENDAL"
                      .text
                      .bold
                      .extraBlack
                      .size(25)
                      .wide
                      .make()
                      .shimmer(
                          secondaryColor: Vx.randomColor,
                          primaryColor: Vx.purple400,
                          showAnimation: true,
                          gradient: LinearGradient(colors: [
                            Colors.green,
                            Colors.blue,
                            Colors.cyan,
                            Colors.indigoAccent,
                          ]))),
              SizedBox(height: 50),
              Bouncing(
                  onPress: () {},
                  child: SignInButton(
                    Buttons.Google,
                    onPressed: () async {
                      signInWithGoogle();
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
