import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/stats/food_category_chart.dart';
import 'package:flutter_application_1/widgets/stats/meals_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More about your Diet Plan"),
        backgroundColor: Colors.green[500],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 4.0),
          child: ListView(children: [
            MealsChart(),
            const SizedBox(
              height: 20,
            ),
            FoodCategoryChart(),
          ]),
        ),
      ),
    );
  }
}
