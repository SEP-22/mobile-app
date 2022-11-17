import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/services/dietPlan/dietplan_services.dart';
import 'package:flutter_application_1/widgets/complete_food_item.dart';
import 'package:flutter_application_1/widgets/food_item.dart';
import 'package:flutter_application_1/widgets/mealButton.dart';
import 'package:http/http.dart';

class WeeklyDietPlan extends StatefulWidget {
  //const WeeklyDietPlan({super.key});
  static const routeName = "/selectedplan";

  @override
  State<WeeklyDietPlan> createState() => _WeeklyDietPlanState();
}

class _WeeklyDietPlanState extends State<WeeklyDietPlan> {
  Map passedArgs = {};
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
  int current = 0; //important, don't del

  String message = "Loading...";
  Map data = {};
  bool loading = true;
  String id = "";

  void getData() async {
    //var temp_dietPlanDetails = new Map();
    //print(passedArgs['planId']);
    var response = await getDietPlanById(passedArgs['planId']);
    if (response is String) {
      setState(() {
        message = response;
      });
    }
    if (response is Map) {
      setState(() {
        data = response;
      });
    }

    setState(() {
      loading = false;
    });
    print("here");
    //print(data);
  }

  // @override
  // void initState() {
  //   //getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    if (passedArgs.isEmpty) {
      passedArgs = ModalRoute.of(context)?.settings.arguments as Map;
      getData();
    } else {
      //getData();
    }
    // passedArgs = passedArgs.isNotEmpty
    //     ? passedArgs
    //     : ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
          title: Text(passedArgs['name']),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: passedArgs['status']
              ? [
                  PopupMenuButton(
                      itemBuilder: (context) => [
                            PopupMenuItem<int>(
                              value: 1,
                              child: Text("Delete"),
                            ),
                          ],
                      onSelected: ((item) => SelectedItem(context, item))),
                ]
              : [
                  PopupMenuButton(
                      itemBuilder: (context) => [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Text("Activate"),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Text("Delete"),
                            ),
                          ],
                      onSelected: ((item) => SelectedItem(context, item))),
                ]),
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
              child: data.isNotEmpty
                  ? Column(children: [
                      MealNameContainer("BREAKFAST"),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 200,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: data[current][0]),
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
                          children: data[current][1],
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
                          children: data[current][2],
                        ),
                      ),
                    ])
                  : Center(
                      child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2,
                        wordSpacing: 10,
                      ),
                    )),
            ),
          ]),
        ),
      ),
    );
  }

  SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        print("Activate");
        break;
      case 1:
        print("Delete");
        break;
    }
  }
}
