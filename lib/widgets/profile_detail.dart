import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileDetailBar extends StatefulWidget {
  late String type;
  late String data;
  late bool isVisible;

  ProfileDetailBar(String type, String data, bool isVisible) {
    this.type = type;
    this.data = data;
    this.isVisible = isVisible;
  }

  @override
  State<ProfileDetailBar> createState() => _ProfileDetailBarState();
}

class _ProfileDetailBarState extends State<ProfileDetailBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Text(
          widget.type,
          style: TextStyle(color: Colors.blueGrey, fontSize: 15),
          textAlign: TextAlign.left,
        ),
        Text(
          widget.data,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ]),
    );
  }
}
