import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/services/dietPlan/dietplan_services.dart';
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
  int current = 0; //important, don't del

  String message = "";
  Map data = {};
  bool loading = true;

  void getData() async {
    var temp_dietPlanDetails = new Map();
    var response = await getDietPlanById();
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
    print(data);
  }

  List<Widget> formattedFoods = [
    CompleteFoodItem(
        "Egg",
        "https://img2.10bestmedia.com/WebStories/19945/40689.jpg",
        "100 g",
        "120 cal"),
    CompleteFoodItem(
        "Turnip",
        "https://thumbs.dreamstime.com/b/fresh-whole-purple-radish-white-background-copy-space-organic-food-fresh-whole-purple-turnip-white-background-126461535.jpg",
        "100 g",
        "120 cal"),
    CompleteFoodItem(
        "Cauliflower",
        "https://img.freepik.com/premium-photo/fresh-cauliflower-isolated-white-background_33736-2684.jpg?w=2000",
        "100 g",
        "120 cal")
  ];
  List<Widget> formattedFoods1 = [
    CompleteFoodItem(
        "Egg",
        "https://img2.10bestmedia.com/WebStories/19945/40689.jpg",
        "100 g",
        "120 cal"),
    CompleteFoodItem(
        "Turnip",
        "https://thumbs.dreamstime.com/b/fresh-whole-purple-radish-white-background-copy-space-organic-food-fresh-whole-purple-turnip-white-background-126461535.jpg",
        "100 g",
        "120 cal")
  ];

  // List weekFoods = [[CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg")],
  // [CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg")],
  // [CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg")],
  // [CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg")],
  // [CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg")],
  // [CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg")],
  // [CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg"),CompleteFoodItem("Egg","https://img2.10bestmedia.com/WebStories/19945/40689.jpg")]];
  //

  List weekFoods = [
    [
      CompleteFoodItem(
          "Egg",
          "https://img2.10bestmedia.com/WebStories/19945/40689.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Turnip",
          "https://thumbs.dreamstime.com/b/fresh-whole-purple-radish-white-background-copy-space-organic-food-fresh-whole-purple-turnip-white-background-126461535.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Cauliflower",
          "https://img.freepik.com/premium-photo/fresh-cauliflower-isolated-white-background_33736-2684.jpg?w=2000",
          "100 g",
          "120 cal")
    ],
    [
      CompleteFoodItem(
          "Egg",
          "https://img2.10bestmedia.com/WebStories/19945/40689.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Turnip",
          "https://thumbs.dreamstime.com/b/fresh-whole-purple-radish-white-background-copy-space-organic-food-fresh-whole-purple-turnip-white-background-126461535.jpg",
          "100 g",
          "120 cal")
    ],
    [
      CompleteFoodItem(
          "Egg",
          "https://img2.10bestmedia.com/WebStories/19945/40689.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Turnip",
          "https://thumbs.dreamstime.com/b/fresh-whole-purple-radish-white-background-copy-space-organic-food-fresh-whole-purple-turnip-white-background-126461535.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Cauliflower",
          "https://img.freepik.com/premium-photo/fresh-cauliflower-isolated-white-background_33736-2684.jpg?w=2000",
          "100 g",
          "120 cal")
    ],
    [
      CompleteFoodItem(
          "Egg",
          "https://img2.10bestmedia.com/WebStories/19945/40689.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Turnip",
          "https://thumbs.dreamstime.com/b/fresh-whole-purple-radish-white-background-copy-space-organic-food-fresh-whole-purple-turnip-white-background-126461535.jpg",
          "100 g",
          "120 cal")
    ],
    [
      CompleteFoodItem(
          "Egg",
          "https://img2.10bestmedia.com/WebStories/19945/40689.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Turnip",
          "https://thumbs.dreamstime.com/b/fresh-whole-purple-radish-white-background-copy-space-organic-food-fresh-whole-purple-turnip-white-background-126461535.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Cauliflower",
          "https://img.freepik.com/premium-photo/fresh-cauliflower-isolated-white-background_33736-2684.jpg?w=2000",
          "100 g",
          "120 cal")
    ],
    [
      CompleteFoodItem(
          "Egg",
          "https://img2.10bestmedia.com/WebStories/19945/40689.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Turnip",
          "https://thumbs.dreamstime.com/b/fresh-whole-purple-radish-white-background-copy-space-organic-food-fresh-whole-purple-turnip-white-background-126461535.jpg",
          "100 g",
          "120 cal")
    ],
    [
      CompleteFoodItem(
          "Egg",
          "https://img2.10bestmedia.com/WebStories/19945/40689.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Turnip",
          "https://thumbs.dreamstime.com/b/fresh-whole-purple-radish-white-background-copy-space-organic-food-fresh-whole-purple-turnip-white-background-126461535.jpg",
          "100 g",
          "120 cal"),
      CompleteFoodItem(
          "Cauliflower",
          "https://img.freepik.com/premium-photo/fresh-cauliflower-isolated-white-background_33736-2684.jpg?w=2000",
          "100 g",
          "120 cal")
    ]
  ];
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text(data['name']),
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
}
