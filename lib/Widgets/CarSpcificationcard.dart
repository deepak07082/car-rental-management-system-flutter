import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CarSpecCard extends StatelessWidget {
  final String title;
  final String spec;

  const CarSpecCard({Key key, this.title, this.spec}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Vx.white,
       
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          "$title".text.gray900.wider.bold.size(15).make(),
          "$spec".text.extraBold.gray900.size(17).heightLoose.make().py4(),
        ],
      ),
    );
  }
}
