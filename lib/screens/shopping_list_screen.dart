import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'package:flutter_application_1/widgets/food_item.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List completeShoppingList = [];
  List<String> shoppingListNames = [];
  String? valueChosen;
  List currentShoppingList = [];
  var slMap = new Map();
  //food template
  //List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

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
  @override
  void initState() {
    getShoppingList();
    super.initState();
  }

  Future<void> getShoppingList() async {
    List<String> temp_shoppingListNames = [];
    var temp_map = new Map();
    //food template data

    var response = await api_service.fetchGet(
        "http://192.168.1.9:4000/shoppingList/getShoppingListsFromUserId/6360cf9f0ebc552ba5863f87");
    print("shoppingList taken");
    var data = json.decode(response.body);
    for (var shoppingList in data) {
      temp_shoppingListNames.add(shoppingList[0]);
      temp_map[shoppingList[0]] = [shoppingList[2], shoppingList[1]];
    }
    print(temp_shoppingListNames);
    print(temp_map);

    setState(() {
      shoppingListNames = temp_shoppingListNames;
      //shoppingListValues = temp_shoppingListValues;
      slMap = temp_map;
    });
  }

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
        title: Text('My Shopping Lists'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                  color: Colors.white, //<-- SEE HERE
                ),
                margin: EdgeInsets.all(10),
                child: DropdownButton<String>(
                  value: valueChosen,
                  hint: const Text("Select Shopping List"),
                  items: shoppingListNames.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(slMap[value][0]),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      valueChosen = newValue!;
                      currentShoppingList = slMap[newValue][1];
                      print(valueChosen);
                      print(currentShoppingList);
                    });
                  },
                ),
              ),
            ),
            Column(
              children: currentShoppingList
                  // .map((e) => FoodItem(e[0], e[3], e[2]))
                  // .toList(),
                  .map((e) => foodTemplate(Food(e[0], '${e[1]}', "200", e[3])))
                  .toList(),
            ),
          ],
          //children: foods.map((e) => foodTemplate(e)).toList(),
        ),
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
