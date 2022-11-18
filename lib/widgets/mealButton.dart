import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MealNameContainer extends StatefulWidget {
  late String name;

  MealNameContainer(this.name);

  @override
  State<MealNameContainer> createState() => _MealNameContainerState();
}

class _MealNameContainerState extends State<MealNameContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5)
            ],
            color: Color(0xfff178b6)),
        child: Center(
          child: Text(
            widget.name,
            style: TextStyle(
                fontSize: 20, fontFamily: 'Varela', color: Colors.black),
          ),
        ),
      ),
    );
  }
}
