import 'package:flutter/material.dart';

class Water extends StatelessWidget {
  Water({Key key, this.width, this.height}) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      width: width,
      height: height,
    );
  }
}