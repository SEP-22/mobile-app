import 'dart:convert';

import 'package:flutter_application_1/screens/create_diet_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/food_item.dart';
import 'package:flutter_application_1/widgets/navigation_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = "/landingScreen";

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xfff178b6),
    minimumSize: const Size(60, 20),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    // print(user.email);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eat Smart "),
        backgroundColor: Colors.green,
      ),
      drawer: const NavDrawer(),
      body: Container(
        color: Colors.green[100],
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    // ignore: sort_child_properties_last
                    children: [
                      const Text(
                        "Are you falling behind of your fitness goals? \nWorry no more because we've got you covered. Your very own personalised diet plan is few clicks away. Complete this quiz to get a balanced diet with your own food preferences that comes with all the essential nutrients. To help you in groceries, each diet plan comes with a shopping list!!. Hurry up and create your diet plan NOW!!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: Image.network(
                          "https://sooma.ca/wp-content/uploads/sites/78/2022/04/food-choices.jpeg",
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(CreateDietPlanScreen.routeName);
                        },
                        child: const Text(
                          'Create Your Diet Plan',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
