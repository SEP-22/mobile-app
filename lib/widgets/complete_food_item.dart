import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CompleteFoodItem extends StatefulWidget {
  late String title;
  late String img;
  late String amount;
  late String calorie;
  CompleteFoodItem(this.title, this.img, this.amount, this.calorie);

  @override
  State<CompleteFoodItem> createState() => _CompleteFoodItemState();
}

class _CompleteFoodItemState extends State<CompleteFoodItem> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Hero(
            tag: "Title",
            child: Image.network(
              widget.img,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            widget.amount,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.check_box),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ),
      ),
    );
    ;
  }
}
