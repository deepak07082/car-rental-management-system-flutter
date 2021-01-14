import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _buildInfo1(),
            _buildInfo2(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo1() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('Assets/ob2.png',),
                        
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('DD Car Rendal').text.size(17).bold.make(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      size: 23,
                    ),
                    title: Text("Version").text.size(13).bold.make(),
                    subtitle: Text("1.0").text.size(12).make(),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.cached,
                      size: 23,
                    ),
                    title: Text("Changelog").text.size(13).bold.make(),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.offline_pin,
                      size: 23,
                    ),
                    title: Text("License").text.size(13).bold.make(),
                    onTap: () {},
                  ),
                ],
              )),
        ));
  }

  Widget _buildInfo2() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Author').text.size(17).bold.make(),
                  HeightBox(10),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 23,
                    ),
                    title: Text("Deepakkumar").text.size(13).bold.make(),
                    subtitle: Text("Coimbatore,TamilNadu").text.size(12).make(),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.file_download,
                      size: 23,
                    ),
                    title:
                        Text("Download From Cloud").text.size(13).bold.make(),
                    onTap: () {},
                  ),
                ],
              )),
        ));
  }
}
