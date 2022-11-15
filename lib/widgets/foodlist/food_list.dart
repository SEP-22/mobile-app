import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_application_1/widgets/foodlist/food_card.dart';

class FoodList extends StatefulWidget {
  static const routeName = "/selectedfoodlist";

  FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}


class _FoodListState extends State<FoodList> {
  Map args = {};

  @override
  Widget build(BuildContext context) {
    args = args.isNotEmpty
        ? args
        : ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(args['type']),
        backgroundColor: Colors.green[500],
      ),
      body: Container(
        color: Colors.lightGreen[100],
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(args['data'].length, (index) {
            return Card(
              child: Center(
                  child: FoodCard(
                food: args['data'][index],
              )),
            );
          }),
        ),
      ),
    );
  }
}
