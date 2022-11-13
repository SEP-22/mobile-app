import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FoodItem extends StatefulWidget {

  late String title;
  late String img;
  FoodItem(this.title,this.img);

  @override
  State<FoodItem> createState() => _FoodItemState();

  
}

class _FoodItemState extends State<FoodItem> {

  
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
