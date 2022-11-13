import 'package:flutter_application_1/screens/create_diet_plan_screen.dart';
import 'package:flutter_application_1/screens/selectFoodScreen.dart';
import 'package:flutter_application_1/screens/landing_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
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
      
      home:  LandingScreen(),
      routes: {
        CreateDietPlanScreen.routeName:(context) => CreateDietPlanScreen(),
        FoodScreen.routeName:(context) => FoodScreen(),
      },
    );
  }
}

