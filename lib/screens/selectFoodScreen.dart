import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/widgets/food_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});
  static const routeName = "/selectFood";
  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List food = [];
  List<Widget> Vegetables_Fruits = [];
  List<Widget> StarchyFood = [];
  List<Widget> Proteins = [];
  List<Widget> Dairy_Fat = [];
  List<Widget> Sugar = [];
  int foodCategory = 1;

  @override
  void initState() {
    getFoods();
    super.initState();
  }

  Future<void> getFoods() async {
    List<Widget> temp_Vegetables_Fruits = [];
    List<Widget> temp_StarchyFood = [];
    List<Widget> temp_Proteins = [];
    List<Widget> temp_Dairy_Fat = [];
    List<Widget> temp_Sugar = [];

    var response =
        await api_service.fetchGet("http://localhost:4000/food/foodbycategory");
    print("fff");
    var data = json.decode(response.body);

    for (var info in data["Vegetables_Fruits"]) {
      FoodItem temp = FoodItem(info["name"], info["image"]);
      temp_Vegetables_Fruits.add(temp);
    }

    for (var info in data["StarchyFood"]) {
      FoodItem temp = FoodItem(info["name"], info["image"]);
      temp_StarchyFood.add(temp);
    }

    for (var info in data["Proteins"]) {
      FoodItem temp = FoodItem(info["name"], info["image"]);
      temp_Proteins.add(temp);
    }

    for (var info in data["Dairy_Fat"]) {
      FoodItem temp = FoodItem(info["name"], info["image"]);
      temp_Dairy_Fat.add(temp);
    }

    for (var info in data["Sugar"]) {
      FoodItem temp = FoodItem(info["name"], info["image"]);
      temp_Sugar.add(temp);
    }

    setState(() {
      Vegetables_Fruits = temp_Vegetables_Fruits;
      StarchyFood = temp_StarchyFood;
      Proteins = temp_Proteins;
      Dairy_Fat = temp_Dairy_Fat;
      Sugar = temp_Sugar;
    });
    // print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: false,
        title: const Text(
          "Select Foods",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          foodCategory == 5
              ? Navigator.pop(context)
              : setState(() {
                  foodCategory++;
                });
        },
        icon: const Icon(Icons.arrow_circle_right),
        label: const Text('Next'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Vegetables_Fruits.length > 0
          ? foodCategory == 1
              ? GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: Vegetables_Fruits,
                )
              : foodCategory == 2
                  ? GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: StarchyFood,
                    )
                  : foodCategory == 3
                      ? GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: Proteins,
                        )
                      : foodCategory == 4
                          ? GridView.count(
                              primary: false,
                              padding: const EdgeInsets.all(20),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: Proteins,
                            )
                          : foodCategory == 4
                              ? GridView.count(
                                  primary: false,
                                  padding: const EdgeInsets.all(20),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  children: Dairy_Fat,
                                )
                              : foodCategory == 5
                                  ? GridView.count(
                                      primary: false,
                                      padding: const EdgeInsets.all(20),
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2,
                                      children: Sugar,
                                    )
                                  : Container(
                                      height: 60,
                                      color: Colors.blue,
                                    )
          : Container(
              height: 60,
              color: Colors.blue,
            ),
    );
  }
}
