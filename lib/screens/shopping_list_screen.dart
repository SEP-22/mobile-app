import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShoppingListScreen extends StatefulWidget {
  //const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<Food> foods = [
    Food("Potato", "500 g", "200 cal",
        "https://nix-tag-images.s3.amazonaws.com/752_highres.jpg"),
    Food("Apple", "200 g", "210 cal",
        "https://nix-tag-images.s3.amazonaws.com/384_highres.jpg"),
    // Food("Lettuce", "450 g", "200 cal",
    //     "https://i.pinimg.com/originals/58/42/10/584210d3e40ed884f21ae7306437a2ec.jpg"),
    // Food("Cauliflower", "120 g", "200 cal",
    //     "https://img.freepik.com/premium-photo/fresh-cauliflower-isolated-white-background_33736-2684.jpg?w=2000")
  ];

  Widget foodTemplate(food) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Row(children: [
        Center(
          child: Stack(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(food.image),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              food.name,
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              food.amount,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('My Diet Plans'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: foods.map((e) => foodTemplate(e)).toList(),
      ),
    );
  }
}

class Food {
  String name = '';
  String amount = '';
  String calorie = '';
  String image = '';

  Food(String name, String amount, String calorie, String image) {
    this.name = name;
    this.amount = amount;
    this.calorie = calorie;
    this.image = image;
  }
}

//Food myfood = Food('Potato', '500 g', '130 cal', '');
