import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/stats/food_category_chart.dart';
import 'package:flutter_application_1/widgets/stats/meals_chart.dart';
import 'package:flutter_application_1/widgets/stats/most_prefered_foods.dart';
import '../services/stats/stats_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool loading = true;
  bool active = false;
  String message = "";

  void getData() async {
    var response = await haveActiveDietPlan();
    if (response is String) {
      setState(() {
        message = response;
      });
    }
    if (response is bool) {
      if (response) {
        setState(() {
          active = response;
        });
      } else {
        setState(() {
          message = "No Active Diet Plan yet ..!";
        });
      }
    }

    setState(() {
      loading = false;
    });
    print(response);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More about your Diet Plan"),
        backgroundColor: Colors.green[500],
      ),
      body: active
          ? Container(
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
            )
          : loading
              ? const Center(
                  child: SpinKitSpinningLines(
                    color: Colors.blueGrey,
                    size: 50.0,
                  ),
                )
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
    );
  }
}
