import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'package:flutter_application_1/widgets/food_item.dart';
import 'package:flutter_application_1/widgets/navigation_drawer.dart';
import '../const.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  //String _id = "6360cf9f0ebc552ba5863f87";
  List completeShoppingList = [];
  List<String> shoppingListNames = [];
  String? valueChosen;
  List currentShoppingList = [];
  var slMap = new Map();

  bool? currentUser = false;

  Future<void> getShoppingList(String userId) async {
    List<String> temp_shoppingListNames = [];
    var temp_map = new Map();
    var response = await api_service
        .fetchGet("${uri}shoppingList/getShoppingListsFromUserId/$userId");
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
      slMap = temp_map;
    });
  }

  Widget foodTemplate(food) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5)
            ],
            color: Colors.white),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(food.image))),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                food.name.length > 14
                    ? '${food.name.substring(0, 13)}..'
                    : food.name,
                style: TextStyle(color: Colors.green, fontSize: 22),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                double.parse(food.amount).round() > 1000
                    ? '${double.parse(food.amount).round() / 1000} kg'
                    : '${double.parse(food.amount).round()} g',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ],
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    if (currentUser == false) {
      getShoppingList(user.id);
      setState(() {
        currentUser = true;
      });
    }
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('My Shopping Lists'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: NavDrawer(),
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
                  .map((e) =>
                      foodTemplate(Food(e[0], '${e[1]}', '${e[2]}', e[3])))
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
