import 'package:flutter_application_1/screens/create_diet_plan_screen.dart';
import 'package:flutter_application_1/screens/dietplan_list_screen.dart';
import 'package:flutter_application_1/screens/food_list_screen.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/screens/reminders_page.dart';
import 'package:flutter_application_1/screens/selectFoodScreen.dart';
import 'package:flutter_application_1/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/stats_screen.dart';
import 'package:flutter_application_1/screens/weekly_diet_plan_screen.dart';
import 'package:flutter_application_1/widgets/foodlist/food_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DietPlanListScreen(),
      routes: {
        CreateDietPlanScreen.routeName: (context) => CreateDietPlanScreen(),
        FoodScreen.routeName: (context) => FoodScreen(),
        FoodList.routeName: (context) => FoodList(),
        WeeklyDietPlan.routeName: (context) => WeeklyDietPlan(),
      },
    );
  }
}
