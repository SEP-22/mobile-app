import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/services/dietPlan/dietplan_services.dart';
import 'package:flutter_application_1/widgets/complete_food_item.dart';
import 'package:flutter_application_1/widgets/diet_plan_item.dart';
import 'package:flutter_application_1/widgets/food_item.dart';
import 'package:flutter_application_1/widgets/mealButton.dart';
import 'package:http/http.dart';

class DietPlanSelectorScreen extends StatefulWidget {
  //const DietPlanSelectorScreen({super.key});
  static const routeName = "/selectplan";

  @override
  State<DietPlanSelectorScreen> createState() => _DietPlanSelectorScreenState();
}

class _DietPlanSelectorScreenState extends State<DietPlanSelectorScreen> {
  List<dynamic> passedArgs = [];
  //List of week days
  List<String> weekdays = [
    "Diet Plan 1",
    "Diet Plan 2",
    "Diet Plan 3",
    "Diet Plan 4",
    "Diet Plan 5",
    "Diet Plan 6",
    "Diet Plan 7",
  ];
  int current = 0; //important, don't del

  String message = "Loading...";
  Map data = {};
  bool loading = true;
  String id = "";

  // void getData() async {
  //   //var temp_dietPlanDetails = new Map();
  //   //print(passedArgs['planId']);
  //   var response = await getDietPlanById(passedArgs['planId']);
  //   if (response is String) {
  //     setState(() {
  //       message = response;
  //     });
  //   }
  //   if (response is Map) {
  //     setState(() {
  //       data = response;
  //     });
  //   }

  //   setState(() {
  //     loading = false;
  //   });
  //   print("here");
  //   //print(data);
  // }

  // @override
  // void initState() {
  //   //getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    passedArgs = ModalRoute.of(context)?.settings.arguments as List<dynamic>;

    print(passedArgs);
    // passedArgs = passedArgs.isNotEmpty
    //     ? passedArgs
    //     : ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("Select your diet plan"),
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
              child: passedArgs.isNotEmpty
                  ? Column(children: [
                      MealNameContainer("BREAKFAST"),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 200,
                        child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              return DietPlanItem(
                                  passedArgs[current]["breakfast"][index][0],
                                  passedArgs[current]["breakfast"][index][3],
                                  passedArgs[current]["breakfast"][index][4],
                                  passedArgs[current]["breakfast"][index][1],
                                  passedArgs[current]["breakfast"][index][2]);
                            },
                            itemCount: passedArgs[current]["breakfast"].length),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MealNameContainer("LUNCH"),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 200,
                        child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              return DietPlanItem(
                                  passedArgs[current]["lunch"][index][0],
                                  passedArgs[current]["lunch"][index][3],
                                  passedArgs[current]["lunch"][index][4],
                                  passedArgs[current]["lunch"][index][1],
                                  passedArgs[current]["lunch"][index][2]);
                            },
                            itemCount: passedArgs[current]["lunch"].length),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MealNameContainer("DINNER"),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 200,
                        child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              return DietPlanItem(
                                  passedArgs[current]["dinner"][index][0],
                                  passedArgs[current]["dinner"][index][3],
                                  passedArgs[current]["dinner"][index][4],
                                  passedArgs[current]["dinner"][index][1],
                                  passedArgs[current]["dinner"][index][2]);
                            },
                            itemCount: passedArgs[current]["dinner"].length),
                      ),
                    ])
                  : Center(
                      child: Text(
                      "No Diet Plans",
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
}
