import 'package:animate_do/animate_do.dart';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:car_rendal_app/Widgets/FiliterTitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'DetailPage.dart';

class TopDeals extends StatefulWidget {
  @override
  _TopDealsState createState() => _TopDealsState();
}

class _TopDealsState extends State<TopDeals> {
  bool filiterenabled = false;

  bool filitertype = false;
  String searchText = "";
  String ftype;
  
 @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: AnimatedSearchBar(
          label: "Search",
          labelStyle: TextStyle(fontSize: 16),
          searchStyle: TextStyle(color: Colors.white),
          cursorColor: Colors.black,
          searchDecoration: InputDecoration(
            hintText: "Search",
            alignLabelWithHint: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            print("value on Change");
            setState(() {
              searchText = value;
            });
          },
        ),
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.1),
        child: new Padding(
          padding: const EdgeInsets.all(7.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('cars').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return SlideInDown(
                    child: Container(
                        // color: Colors.blue,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3.0,
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    //color: Colors.blue,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        ds['img'],
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                "${ds["name"]}"
                                    .text
                                    .bold
                                    .size(17)
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
                          ),
                        ).onInkTap(() {
                          Get.to(CarDetailPage(
                            name: ds['name'],
                            model: ds['model'],
                          ));
                        })),
                  );
                },
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, index.isEven ? 2.5 : 2.7),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: SlideInDown(
        child: Container(
          //color: Colors.grey[900].withOpacity(0.2),
          height: MediaQuery.of(context).size.height * 0.085,
          child: SlideInRight(
            child: Row(
              children: [
                filiterenabled == false
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.filter_list_alt,
                          color: Colors.black,
                        ).p(4),
                      ).p(15)
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.filter_list_alt,
                          color: Colors.white,
                        ).p(4),
                      ).p(15),
                WidthBox(10),
                FiliterCard(
                  enabled: ftype == "newest"
                      ? filitertype = true
                      : filitertype = false,
                  name: "Newest",
                  ontap: () {
                    setState(() {
                      filiterenabled == false
                          ? filiterenabled = true
                          : filiterenabled = false;

                      ftype == "newest" ? ftype = null : ftype = "newest";
                    });
                  },
                ),
                WidthBox(10),
                FiliterCard(
                  enabled: ftype == "bestmatch"
                      ? filitertype = true
                      : filitertype = false,
                  name: "Best Match",
                  ontap: () {
                    setState(() {
                      filiterenabled == false
                          ? filiterenabled = true
                          : filiterenabled = false;

                      ftype == "bestmatch" ? ftype = null : ftype = "bestmatch";
                    });
                  },
                ),
                WidthBox(10),
                FiliterCard(
                  enabled: ftype == "lowestprice"
                      ? filitertype = true
                      : filitertype = false,
                  name: "Lowest Price",
                  ontap: () {
                    setState(() {
                      filiterenabled == false
                          ? filiterenabled = true
                          : filiterenabled = false;

                      ftype == "lowestprice"
                          ? ftype = null
                          : ftype = "lowestprice";
                    });
                  },
                ),
                WidthBox(10),
                FiliterCard(
                  enabled: ftype == "highestprice"
                      ? filitertype = true
                      : filitertype = false,
                  name: "Highest Price",
                  ontap: () {
                    setState(() {
                      filiterenabled == false
                          ? filiterenabled = true
                          : filiterenabled = false;

                      ftype == "highestprice"
                          ? ftype = null
                          : ftype = "highestprice";
                    });
                  },
                ),
              ],
            ).scrollHorizontal(),
          ),
        ),
      ),
    );
  }
}
