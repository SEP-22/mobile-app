import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/screens/create_diet_plan_screen.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/screens/selectFoodScreen.dart';
import 'package:flutter_application_1/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:flutter_application_1/screens/stats_screen.dart';
import 'package:flutter_application_1/screens/weekly_diet_plan_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: MyApp()));
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
      home:  Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.role == 'user'
              ?  LandingScreen()
              : const AuthScreen()
          : const AuthScreen(),
      routes: {
        CreateDietPlanScreen.routeName: (context) => CreateDietPlanScreen(),
        LandingScreen.routeName: (context) => LandingScreen(),
        FoodScreen.routeName: (context) => FoodScreen(),
      },
    );
  }
}
