import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/widgets/diet_list_button.dart';
import 'package:flutter_application_1/widgets/mealButton.dart';

class DietPlanListScreen extends StatefulWidget {
  const DietPlanListScreen({super.key});

  @override
  State<DietPlanListScreen> createState() => _DietPlanListScreenState();
}

class _DietPlanListScreenState extends State<DietPlanListScreen> {
  List<String> dietList = [
    "Diet Plan 1111111111111",
    "Diet Plan 2",
    "Mom's Diet Plan"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        title: const Text("My Diet Plans"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.lightGreen[100],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: dietList.map((String value) {
                  return DietListButton(
                    dietPlanName: value,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
