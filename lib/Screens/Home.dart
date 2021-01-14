import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:car_rendal_app/Screens/DetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'TopDeals.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userid, user;
  Future<dynamic> getUserID() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    userid = myPrefs.getString("userid");
    setState(() {
      user = userid;
      print("$user-$userid");
    });
    print(userid);
  }

  @override
  void initState() {
    getUserID();
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

    if (user == null) {
      return Scaffold(
          body: "No Internet Connection \n please Try again!"
              .text
              .makeCentered());
    } else {
      //Size size = MediaQuery.of(context).size;

      return Scaffold(
        body: WillPopScope(
          onWillPop: onWillPop,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              var userDocument = snapshot.data;
              return Container(
                color: Colors.grey.withOpacity(0.1),
                child: VStack(
                  [
                    ZoomIn(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            )),
                        child: VStack([
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SlideInLeft(
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          userDocument['photourl']),
                                      radius: 22.0,
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
                              Row(
                                children: [
                                  "Rs. ".text.gray900.bold.make(),
                                  SlideInLeft(
                                    child:
                                        "${userDocument["Balance"].toString()}"
                                            .text
                                            .bold
                                            .size(20)
                                            .make()
                                            .shimmer(
                                              primaryColor: Colors.blue,
                                              secondaryColor: Colors.indigo,
                                              showAnimation: true,
                                            ),
                                  ),
                                  BouncingWidget(
                                    duration: Duration(milliseconds: 80),
                                    scaleFactor: 2,
                                    onPressed: () {
                                      print("Amt add buttton");
                                    },
                                    child: SlideInRight(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.add,
                                          size: 17,
                                        ),
                                      ).px4(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ).px32().py24(),
                          ZoomIn(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              // color: Colors.green,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                userDocument['img'],
                                fit: BoxFit.fill,
                              ).onTap(() {}),
                            ).px12().py1(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadeIn(
                                    child: "${userDocument["name"]}"
                                        .text
                                        .semiBold
                                        .wide
                                        .size(20)
                                        .black
                                        .make(),
                                  ),
                                  FadeIn(
                                    child: "${userDocument["model"]}"
                                        .text
                                        .gray900
                                        .heightLoose
                                        .make(),
                                  ),
                                ],
                              ),
                              BouncingWidget(
                                  duration: Duration(milliseconds: 50),
                                  scaleFactor: 1.5,
                                  onPressed: () {
                                    print("onPressed");
                                  },
                                  child: Row(
                                    children: [
                                      SlideInLeft(
                                        child: "My Garage"
                                            .text
                                            .semiBold
                                            .size(18)
                                            .blue700
                                            .make(),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: Colors.blue[700],
                                      ).px4(),
                                    ],
                                  ))
                            ],
                          ).px32().py12(),
                        ]),
                      ),
                    ),
                    BouncingWidget(
                        duration: Duration(milliseconds: 100),
                        scaleFactor: 1.5,
                        onPressed: () {
                          print("onPressed");
                        },
                        child: FadeInUp(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Vx.blue500,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: VStack([
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        "Available Cars"
                                            .text
                                            .bold
                                            .size(20)
                                            .white
                                            .make(),
                                        Container(
                                                child:
                                                    "Long Term And Short Term"
                                                        .text
                                                        .semiBold
                                                        .size(14)
                                                        .white
                                                        .make())
                                            .py4(),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.forward,
                                          size: 17,
                                          color: Vx.blue700,
                                        ),
                                      ).px8(),
                                    )
                                  ],
                                ).p16(),
                              ])),
                        )).px24().py24(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SlideInLeft(
                            child: Container(
                                child: "Top Deals"
                                    .text
                                    .black
                                    .size(19)
                                    .bold
                                    .make()
                                    .shimmer()),
                          ),
                          Row(
                            children: [
                              SlideInRight(
                                  child: "More".text.semiBold.blue700.make()),
                              SlideInRight(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 17,
                                  color: Vx.blue700,
                                ).px8(),
                              ),
                            ],
                          ),
                        ],
                      ).onInkTap(() {
                        Get.to(
                          TopDeals(),
                        );
                      }),
                    ).px20(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('cars')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: CircularProgressIndicator());
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds =
                                  snapshot.data.documents[index];
                              return Container(
                                  // color: Colors.blue,
                                  height:
                                      MediaQuery.of(context).size.height * 0.27,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: SlideInRight(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 3.0,
                                      child: Column(
                                        children: [
                                          SlideInLeft(
                                            child: SlideInRight(
                                              child: Container(
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  //color: Colors.blue,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      ds['img'],
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                              ),
                                            ),
                                          ),
                                          "${ds["name"]}"
                                              .text
                                              .bold
                                              .size(18)
                                              .make()
                                              .shimmer(
                                                primaryColor: Colors.blue,
                                                secondaryColor: Colors.pink,
                                              ),
                                          "Rent: Rs.${ds["1monthrent"]}"
                                              .text
                                              .semiBold
                                              .make()
                                              .py8(),
                                        ],
                                      ),
                                    ).onInkTap(() {
                                      Get.to(CarDetailPage(
                                        name: ds['name'],
                                        model: ds['model'],
                                      ));
                                    }),
                                  ));
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ).scrollVertical(),
              );
            },
          ),
        ),
      );
    }
  }
}
