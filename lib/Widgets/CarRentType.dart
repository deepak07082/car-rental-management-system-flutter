import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

class RentType extends StatelessWidget {
  final String type;
  final bool enabled;
  final Function ontap;

  const RentType({Key key, this.type, this.enabled, this.ontap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: enabled == true ? Vx.blue500 : Vx.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            enabled == true
                ? "$type"
                    .text
                    .wider
                    .bold
                    .gray900
                    .maxLines(1)
                    .size(15)
                    .make()
                    .pOnly(
                      top: 25,
                      bottom: 25,
                    )
                : "$type"
                    .text
                    .wider
                    .bold
                    .gray900
                    .maxLines(1)
                    .size(15)
                    .make()
                    .pOnly(
                      top: 25,
                      bottom: 25,
                    ),
          ],
        ),
      ).p(20),
    );
  }
}
