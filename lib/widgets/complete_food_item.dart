import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CompleteFoodItem extends StatefulWidget {
  CompleteFoodItem();

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
            Hero(
              tag: "tag",
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),
                        fit: BoxFit.contain)),
              ),
            ),
            Text(
              "Egg",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Varela', fontSize: 15),
            ),
            Text(
              "190 cal",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Varela', fontSize: 15),
            ),
            Text(
              "Consume 50 g",
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
