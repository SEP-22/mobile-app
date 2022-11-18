import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import '../../services/stats/stats_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FoodCategoryChart extends StatefulWidget {
  FoodCategoryChart({super.key});

  @override
  State<FoodCategoryChart> createState() => _FoodCategoryChartState();
}

class _FoodCategoryChartState extends State<FoodCategoryChart> {
  List data = [];
  String message = "";

  void getData() async {
    var response = await getFoodCategoryPercentage();
    if (response is String) {
      setState(() {
        message = response;
      });
    }
    if (response is List) {
      setState(() {
        data = response;
      });
    }
    print(response);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 25,
                spreadRadius: 10,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 15.0),
          child: Column(children: [
            const Text("Calory distribution by Food Category",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                )),
            AspectRatio(
                aspectRatio: 16 / 9,
                child: data.isNotEmpty
                    ? DChartPie(
                        data: data.map((e) {
                          return {
                            'domain': e['category'],
                            'measure': e['percentage']
                          };
                        }).toList(),
                        fillColor: (pieData, index) {
                          switch (pieData['domain']) {
                            case "Vegetables":
                              return Colors.amber[400];
                            case "Fruits":
                              return Colors.deepOrange[400];
                            case "Starchy food":
                              return Colors.purple[300];
                            case "Proteins":
                              return Colors.lightBlue[400];
                            case "Dairy":
                              return Colors.lightGreen[400];
                            default:
                              return Colors.pink[400];
                          }
                        },
                        labelPosition: PieLabelPosition.outside,
                        labelColor: Colors.black,
                        labelFontSize: 12,
                        labelLineColor: Colors.black12,
                        labelLineThickness: 2,
                        labelLinelength: 10,
                        labelPadding: 3,
                        pieLabel: (Map<dynamic, dynamic> pieData, int? index) {
                          return pieData['domain'] +
                              '\n' +
                              pieData['measure'].toString() +
                              '%';
                        },
                        showLabelLine: true,
                        strokeWidth: 1,
                      )
                    : message == ""
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
                          )))
          ]),
        ),
      ),
    );
  }
}
