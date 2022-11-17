import 'package:flutter/material.dart';

class FoodListButton extends StatelessWidget {
  static Map colors = {
    "All Foods": Colors.orange[300],
    "Fruits and Vegetables": Colors.pink[300],
    "Starchy food": Colors.pink[300],
    "Dairy and Fats": Colors.pink[300],
    "Proteins": Colors.pink[300],
    "Sugar": Colors.pink[300],
  };
  final String type;
  final List data;

  const FoodListButton({super.key, required this.type, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/selectedfoodlist', arguments: {
              'data' : data,
              'type' : type
            });
          },
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            backgroundColor: colors[type],
            fixedSize: const Size(280, 70),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            type,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}
