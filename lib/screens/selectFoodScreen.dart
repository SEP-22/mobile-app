import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/common/widgets/loader.dart';
import 'package:flutter_application_1/screens/create_diet_plan_screen.dart';
import 'package:flutter_application_1/widgets/food_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import '../const.dart';
import '../constants/utils.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});
  static const routeName = "/selectFood";
  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List food = [];
  List<Widget> Vegetables = [];
  List<Widget> Fruits = [];
  List<Widget> StarchyFood = [];
  List<Widget> Proteins = [];
  List<Widget> Dairy = [];
  List<Widget> Fat_Sugar = [];
  int foodCategory = 0;
  List<int> numberOfFoodsSelected = [0, 0, 0, 0, 0, 0];
  int numOfFoodShouldSelect = 6;

  @override
  void initState() {
    getFoods();
    super.initState();
  }

  void increaseFoodCount() {
    setState(() {
      numberOfFoodsSelected[foodCategory] =
          numberOfFoodsSelected[foodCategory] + 1;
    });
    print(numberOfFoodsSelected);
  }

  void decreaseFoodCount() {
    setState(() {
      numberOfFoodsSelected[foodCategory] =
          numberOfFoodsSelected[foodCategory] - 1;
    });
    print(numberOfFoodsSelected);
  }

  Future<void> getFoods() async {
    List<Widget> temp_Vegetables = [];
    List<Widget> temp_Fruits = [];
    List<Widget> temp_StarchyFood = [];
    List<Widget> temp_Proteins = [];
    List<Widget> temp_Dairy = [];
    List<Widget> temp_Fat_Sugar = [];

    var response = await api_service.fetchGet("${uri}food/foodbycategory");
    print("fff");
    var data = json.decode(response.body);
    print(data);

    for (var info in data["Vegetables"]) {
      FoodItem temp = FoodItem(info["_id"], info["name"], info["image"],
          increaseFoodCount, decreaseFoodCount);
      temp_Vegetables.add(temp);
    }

    for (var info in data["Fruits"]) {
      FoodItem temp = FoodItem(info["_id"], info["name"], info["image"],
          increaseFoodCount, decreaseFoodCount);
      temp_Fruits.add(temp);
    }

    for (var info in data["StarchyFood"]) {
      FoodItem temp = FoodItem(info["_id"], info["name"], info["image"],
          increaseFoodCount, decreaseFoodCount);
      temp_StarchyFood.add(temp);
    }

    for (var info in data["Proteins"]) {
      FoodItem temp = FoodItem(info["_id"], info["name"], info["image"],
          increaseFoodCount, decreaseFoodCount);
      temp_Proteins.add(temp);
    }

    for (var info in data["Dairy"]) {
      FoodItem temp = FoodItem(info["_id"], info["name"], info["image"],
          increaseFoodCount, decreaseFoodCount);
      temp_Dairy.add(temp);
    }

    for (var info in data["Fat_Sugar"]) {
      FoodItem temp = FoodItem(info["_id"], info["name"], info["image"],
          increaseFoodCount, decreaseFoodCount);
      temp_Fat_Sugar.add(temp);
    }

    setState(() {
      Vegetables = temp_Vegetables;
      Fruits = temp_Fruits;
      StarchyFood = temp_StarchyFood;
      Proteins = temp_Proteins;
      Dairy = temp_Dairy;
      Fat_Sugar = temp_Fat_Sugar;
    });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          foodCategory == 0
              ? "Vegetables"
              : foodCategory == 1
                  ? "Fruits"
                  : foodCategory == 2
                      ? "Starchy Foods"
                      : foodCategory == 3
                          ? "Proteins"
                          : foodCategory == 4
                              ? "Dairy"
                              : foodCategory == 5
                                  ? "Fats and Sugar"
                                  : "Select Foods",
          style: const TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton.extended(
                heroTag: "back",
                onPressed: () {
                  if (foodCategory == 0) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      foodCategory--;
                    });
                  }
                },
                icon: const Icon(Icons.arrow_circle_left),
                label: const Text('Back'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              heroTag: "next",
              onPressed: () {
                if (foodCategory == 5) {
                  Navigator.pop(context);
                } else {
                  if (numberOfFoodsSelected[foodCategory] <
                      numOfFoodShouldSelect) {
                    showSnackBar(context,
                        "You should select atleast ${numOfFoodShouldSelect} foods.");
                  } else {
                    setState(() {
                      foodCategory++;
                    });
                  }
                }
              },
              icon: const Icon(Icons.arrow_circle_right),
              label: const Text('Next'),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Vegetables.isNotEmpty
          ? foodCategory == 0
              ? GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: Vegetables,
                )
              : foodCategory == 1
                  ? GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: Fruits,
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
                                  children: Dairy,
                                )
                              : foodCategory == 5
                                  ? GridView.count(
                                      primary: false,
                                      padding: const EdgeInsets.all(20),
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2,
                                      children: Fat_Sugar,
                                    )
                                  : const Loader()
          : const Loader(),
    );
  }
}
