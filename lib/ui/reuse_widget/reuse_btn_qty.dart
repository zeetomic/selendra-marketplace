import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';

class ReuseBtnQty extends StatelessWidget {
  final Function onTap;
  final IconData iconData;
  final double height;
  final double width;

  ReuseBtnQty(this.onTap, this.iconData, {this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height ?? 40.0,
          width: width ?? 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: kDefaultColor, width: 2)
          ),
          child: Icon(
            iconData,
            color: kDefaultColor,
          ),
        ),
      ),
    );
  }
}
