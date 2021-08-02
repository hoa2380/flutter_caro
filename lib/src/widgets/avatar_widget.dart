
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  String url;
  double height;
  double width;
  Color color;
  AvatarWidget({this.url, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffE86F2A),
          width: 5,
        ),
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Image.asset(
        url, fit: BoxFit.fitHeight,
      ),
    );
  }
}
