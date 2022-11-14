import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/stats/food_category_chart.dart';
import 'package:flutter_application_1/widgets/stats/meals_chart.dart';
import 'package:flutter_application_1/widgets/stats/most_prefered_foods.dart';

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
        color: Colors.white,
        child: ListView(children: [
          MealsChart(),
          const SizedBox(
            height: 20,
          ),
          FoodCategoryChart(),
          const SizedBox(
            height: 20,
          ),
          MostOccuringFoods(),
        ]),
      ),
    );
  }
}
