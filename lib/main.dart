import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/screens/create_diet_plan_screen.dart';
import 'package:flutter_application_1/screens/diet_plan_select_screen.dart';
import 'package:flutter_application_1/screens/dietplan_list_screen.dart';
import 'package:flutter_application_1/screens/edit_email_screen.dart';
import 'package:flutter_application_1/screens/edit_food_select_screen.dart';
import 'package:flutter_application_1/screens/edit_name_screen.dart';
import 'package:flutter_application_1/screens/edit_password_screen.dart';
import 'package:flutter_application_1/screens/edit_phone_screen.dart';
import 'package:flutter_application_1/screens/food_list_screen.dart';
import 'package:flutter_application_1/screens/manage_screen.dart.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/screens/reminders_page.dart';
import 'package:flutter_application_1/screens/selectFoodScreen.dart';
import 'package:flutter_application_1/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:flutter_application_1/screens/stats_screen.dart';
import 'package:flutter_application_1/screens/weekly_diet_plan_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/widgets/foodlist/food_list.dart';

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
      title: 'Eat Smart',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.role == 'user'
              ? LandingScreen()
              : const AuthScreen()
          : AuthScreen(),
      routes: {
        CreateDietPlanScreen.routeName: (context) => CreateDietPlanScreen(),
        LandingScreen.routeName: (context) => LandingScreen(),
        FoodScreen.routeName: (context) => FoodScreen(),
        FoodList.routeName: (context) => FoodList(),
        WeeklyDietPlan.routeName: (context) => WeeklyDietPlan(),
        DietPlanSelectorScreen.routeName: (context) => DietPlanSelectorScreen(),
        EditFoodScreen.routeName: (context) => EditFoodScreen(),
        EditName.routeName: (context) => EditName(),
        EditPhone.routeName: (context) => EditPhone(),
        EditEmail.routeName: (context) => EditEmail(),
        EditPassword.routeName: (context) => EditPassword(),
      },
    );
  }
}
