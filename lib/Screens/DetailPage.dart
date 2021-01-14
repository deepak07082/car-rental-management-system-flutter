import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:car_rendal_app/Widgets/BouncingButton.dart';
import 'package:car_rendal_app/Widgets/CarRentType.dart';
import 'package:car_rendal_app/Widgets/CarSpcificationcard.dart';
import 'package:car_rendal_app/Widgets/rentdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:velocity_x/velocity_x.dart';

class CarDetailPage extends StatefulWidget {
  final String name;
  final String model;

  const CarDetailPage({Key key, this.name, this.model}) : super(key: key);

  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  bool bookmark = false;
  String rent = "Please Select";
  int amt = 0;
  String type = "monthlykm";
  DateTime date = DateTime.now();
  bool bookingstatus = false;
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black12.withOpacity(0.5),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cars')
              .doc(widget.name)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            var cardetail = snapshot.data;

            return Container(
                color: Colors.grey.withOpacity(0.1),
                child: VStack([
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                    child: VStack(
                      [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Bouncing(
                              onPress: () {},
                              child: SlideInLeft(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: 18,
                                  ).p(6),
                                ),
                              ),
                            ),
                            SlideInRight(
                              child: Row(
                                children: [
                                  bookmark == false
                                      ? Bouncing(
                                          onPress: () {
                                            setState(() {
                                              bookmark = true;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              Icons.bookmark_outline,
                                              color: Colors.black,
                                              size: 22,
                                            ).p(9),
                                          )).px8()
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Vx.blue500,
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            Icons.bookmark,
                                            color: Colors.white,
                                            size: 22,
                                          ).p(9),
                                        ).onInkTap(() {
                                          setState(() {
                                            bookmark = false;
                                          });
                                        }).px8(),
                                  Bouncing(
                                      onPress: () {
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.share,
                                          color: Colors.black,
                                          size: 22,
                                        ).p(9),
                                      )).px4().onInkTap(() {
                                    Share.share(
                                        'check this car ${cardetail['img']}');
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ).p(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SlideInLeft(
                              child: "${cardetail['name']}"
                                  .text
                                  .extraBold
                                  .extraBlack
                                  .wide
                                  .size(30)
                                  .black
                                  .make()
                                  .shimmer(
                                      primaryColor: Colors.indigo[700],
                                      secondaryColor: Vx.blue500),
                            ),
                            SlideInLeft(
                              child: "${cardetail['model']}"
                                  .text
                                  .extraBlack
                                  .heightLoose
                                  .make(),
                            ),
                          ],
                        ).px20(),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          // color: Colors.green,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ZoomIn(
                            child: Image.network(
                              cardetail['img'],
                              fit: BoxFit.fill,
                            ).onTap(() {}),
                          ),
                        ).px12().py1(),
                        SlideInRight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              rent == "1month"
                                  ? RentDetail(
                                      amt: cardetail['1monthrent'],
                                      rent: 1,
                                      enabled: true,
                                      ontap: () {
                                        setState(() {
                                          rent = "1month";
                                          amt = cardetail['1monthrent'];
                                        });
                                      },
                                    )
                                  : RentDetail(
                                      amt: cardetail['1monthrent'],
                                      rent: 1,
                                      enabled: false,
                                      ontap: () {
                                        setState(() {
                                          rent = "1month";
                                          amt = cardetail['1monthrent'];
                                        });
                                      },
                                    ),
                              rent == "6month"
                                  ? RentDetail(
                                      amt: cardetail['6monthrent'],
                                      rent: 6,
                                      enabled: true,
                                      ontap: () {
                                        setState(() {
                                          rent = "6month";
                                          amt = cardetail['6monthrent'];
                                        });
                                      },
                                    )
                                  : RentDetail(
                                      amt: cardetail['6monthrent'],
                                      rent: 6,
                                      enabled: false,
                                      ontap: () {
                                        setState(() {
                                          rent = "6month";
                                          amt = cardetail['6monthrent'];
                                        });
                                      },
                                    ),
                              rent == "12month"
                                  ? RentDetail(
                                      amt: cardetail['12monthrent'],
                                      rent: 12,
                                      enabled: true,
                                      ontap: () {
                                        setState(() {
                                          rent = "12month";
                                          amt = cardetail['12monthrent'];
                                        });
                                      },
                                    )
                                  : RentDetail(
                                      amt: cardetail['12monthrent'],
                                      rent: 12,
                                      enabled: false,
                                      ontap: () {
                                        setState(() {
                                          rent = "12month";
                                          amt = cardetail['12monthrent'];
                                        });
                                      },
                                    ),
                            ],
                          ).p24(),
                        ),
                      ],
                    ),
                  ),
                  SlideInLeft(
                    child: "Specifications"
                        .text
                        .bold
                        .extraBlack
                        .size(18)
                        .wider
                        .make()
                        .px32()
                        .py20()
                        .shimmer(
                          primaryColor: Colors.indigo[700],
                          secondaryColor: Vx.blue500,
                        ),
                  ),
                  SlideInLeft(
                    child: Row(
                      children: [
                        CarSpecCard(
                          spec: cardetail['color'],
                          title: "Color",
                        ),
                        WidthBox(25),
                        CarSpecCard(
                          spec: cardetail['seat'],
                          title: "Seat",
                        ),
                        WidthBox(25),
                        CarSpecCard(
                          spec: cardetail['gear'],
                          title: "Gear",
                        ),
                        WidthBox(25),
                        CarSpecCard(
                          spec: "${cardetail['fuel']} L",
                          title: "Fuel",
                        ),
                      ],
                    ).pLTRB(25, 15, 0, 15).scrollHorizontal(),
                  ),
                  SlideInRight(
                    child: Row(
                      children: [
                        type == "monthlykm"
                            ? RentType(
                                enabled: true,
                                type: "Monthly KM",
                                ontap: () {
                                  setState(() {
                                    type = "monthlykm";
                                  });
                                },
                              )
                            : RentType(
                                enabled: false,
                                type: "Monthly KM",
                                ontap: () {
                                  setState(() {
                                    type = "monthlykm";
                                  });
                                },
                              ),
                        type == "exceedingmonthly"
                            ? RentType(
                                enabled: true,
                                type: "Unlimited KM'S",
                                ontap: () {
                                  setState(() {
                                    type = "exceedingmonthly";
                                  });
                                },
                              )
                            : RentType(
                                enabled: false,
                                type: "Limited KM",
                                ontap: () {
                                  setState(() {
                                    type = "exceedingmonthly";
                                  });
                                },
                              ),
                      ],
                    ).scrollHorizontal(),
                  ),
                ]).scrollVertical());
          }),
      bottomNavigationBar: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cars')
              .doc(widget.name)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            var cardetail = snapshot.data;

            return Container(
                height: MediaQuery.of(context).size.height * 0.13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SlideInLeft(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "$rent".text.semiBold.wide.size(17).make(),
                          "RS. $amt"
                              .text
                              .heightLoose
                              .bold
                              .extraBlack
                              .size(18)
                              .make(),
                        ],
                      ),
                    ),
                    Bouncing(
                      onPress: () {
                        if (rent != "" && amt != 0) {
                          firestoreInstance
                              .collection("users")
                              .doc("booked cars")
                              .set({
                            "rentmonth": rent,
                            "rentamt": amt,
                            "seat": cardetail['seat'],
                            "date": date.day,
                            "time":
                                "${date.hour}.${date.minute}.${date.second}",
                            "color": cardetail['color'],
                            "model": cardetail['model'],
                            "name": cardetail['name'],
                          });
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.LEFTSLIDE,
                              headerAnimationLoop: false,
                              dialogType: DialogType.SUCCES,
                              title: 'Succes',
                              desc: 'Car Booked Successfully..',
                              btnOkOnPress: () {
                                debugPrint('OnClcik');
                              },
                              btnOkIcon: Icons.check_circle,
                              onDissmissCallback: () {
                                debugPrint('Dialog Dissmiss from callback');
                              })
                            ..show();
                          setState(() {
                            bookingstatus = true;
                          });
                        } else {
                          bookingstatus = false;
                          toast();
                        }
                      },
                      child: SlideInRight(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: "Select this car"
                              .text
                              .white
                              .wide
                              .semiBold
                              .size(18)
                              .make()
                              .shimmer(
                                primaryColor: Colors.white,
                                secondaryColor: Colors.green,
                              )
                              .px12()
                              .py16(),
                        ),
                      ),
                    ),
                  ],
                ).p20());
          }),
    );
  }

  toast() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'Error',
        desc: 'Please Select Data',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }
}
