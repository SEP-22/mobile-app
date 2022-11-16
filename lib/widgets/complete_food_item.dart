import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CompleteFoodItem extends StatefulWidget {
  late String img;
  late String name;
  late String amount;
  late String calorie;

  CompleteFoodItem(String name, String img, String amount, String calorie) {
    this.name = name;
    this.img = img;
    this.amount = amount;
    this.calorie = calorie;
  }

  @override
  State<CompleteFoodItem> createState() => _CompleteFoodItemState();
}

class _CompleteFoodItemState extends State<CompleteFoodItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5)
            ],
            color: Colors.white),
        child: Column(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.img), fit: BoxFit.contain)),
            ),
            Text(
              widget.name,
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Varela', fontSize: 15),
            ),
            Text(
              widget.calorie,
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Varela', fontSize: 15),
            ),
            Text(
              widget.amount,
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Varela', fontSize: 15),
            )
          ],
        ),
      ),
    );
    ;
  }
}
