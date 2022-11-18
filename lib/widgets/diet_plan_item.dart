import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DietPlanItem extends StatelessWidget {

  late String id;
  late String img;
  late String name;
  late String cal;
  late String amount;

  DietPlanItem(this.id,this.img,this.name,this.cal,this.amount);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 4,
          )),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Hero(
            tag: id,
            child: Image.network(
              img,
              fit: BoxFit.cover,
            ),
          ),
          ),
        ),
        title: Text(
          name,
        ),
        subtitle: Text(
          cal,
        ),
        trailing:Text(
          amount,
        )
      ),
    );
    
  }
}