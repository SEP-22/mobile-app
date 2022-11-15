import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/widgets/complete_food_item.dart';
import 'package:flutter_application_1/widgets/food_item.dart';
import 'package:flutter_application_1/widgets/mealButton.dart';

class WeeklyDietPlan extends StatefulWidget {
  const WeeklyDietPlan({super.key});

  @override
  State<WeeklyDietPlan> createState() => _WeeklyDietPlanState();
}

class _WeeklyDietPlanState extends State<WeeklyDietPlan> {
  //List of week days
  List<String> weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  int current = 0;
  List<Widget> formattedFoods = [
    CompleteFoodItem(),
    CompleteFoodItem(),
    CompleteFoodItem()
  ];
  List<Widget> formattedFoods1 = [CompleteFoodItem(), CompleteFoodItem()];
  List weekFoods = [
    [CompleteFoodItem(), CompleteFoodItem(), CompleteFoodItem()],
    [CompleteFoodItem(), CompleteFoodItem()],
    [CompleteFoodItem(), CompleteFoodItem(), CompleteFoodItem()],
    [CompleteFoodItem(), CompleteFoodItem()],
    [CompleteFoodItem(), CompleteFoodItem(), CompleteFoodItem()],
    [CompleteFoodItem(), CompleteFoodItem()],
    [CompleteFoodItem(), CompleteFoodItem(), CompleteFoodItem()]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("My Diet Plan"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          //width: double.infinity,
          //height: double.infinity,
          margin: const EdgeInsets.all(5),
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              height: 100,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: weekdays.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(10),
                            width: (MediaQuery.of(context).size.width - 70) / 3,
                            height: 45,
                            decoration: BoxDecoration(
                              color: current == index
                                  ? Colors.white70
                                  : Colors.white54,
                              borderRadius: current == index
                                  ? BorderRadius.circular(15)
                                  : BorderRadius.circular(10),
                              border: current == index
                                  ? Border.all(
                                      color: Colors.pinkAccent, width: 2)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                weekdays[index],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: current == index,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Colors.pinkAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
            ),
            Container(
              child: Column(children: [
                MealNameContainer("BREAKFAST"),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 200,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: weekFoods[current]),
                ),
                SizedBox(
                  height: 10,
                ),
                MealNameContainer("LUNCH"),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: weekFoods[current],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MealNameContainer("DINNER"),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: weekFoods[current],
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
