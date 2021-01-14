import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FiliterCard extends StatelessWidget {
  final String name;
  final bool enabled;
  final Function ontap;

  const FiliterCard({Key key, this.name, this.enabled, this.ontap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: enabled == true ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: enabled == true
              ? Border.all(color: Colors.white)
              : Border.all(color: Colors.black),
        ),
        child: enabled == true
            ? "$name".text.semiBold.size(16).white.make().p(4)
            : "$name".text.semiBold.size(16).gray900.make().p(4),
      ),
    );
  }
}
