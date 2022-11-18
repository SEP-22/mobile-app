import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/create_diet_plan_screen.dart';
import 'package:flutter_application_1/screens/manage_screen.dart.dart';

class EditFoodItem extends StatefulWidget {
  late String id;
  late String title;
  late String img;
  EditFoodItem(this.id, this.title, this.img);

  @override
  State<EditFoodItem> createState() => _EditFoodItemState();
}

class _EditFoodItemState extends State<EditFoodItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as SelectFoodArguments1;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Hero(
            tag: widget.id,
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
            icon: arg.selectedFood.contains(widget.id)
                ? Icon(Icons.check_box)
                : Icon(Icons.check_box_outline_blank),
            color: Theme.of(context).accentColor,
            onPressed: () {
              setState(() {
                arg.addFood(widget.id);
              });
            },
          ),
        ),
      ),
    );
    ;
  }
}
