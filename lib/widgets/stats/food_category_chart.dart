import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'dart:convert';

class FoodCategoryChart extends StatefulWidget {
  FoodCategoryChart({super.key});

  @override
  State<FoodCategoryChart> createState() => _FoodCategoryChartState();
}

class _FoodCategoryChartState extends State<FoodCategoryChart> {
  List<Map> data = [];

  @override
  void initState() {
    getData();
    print("object");
    super.initState();
  }

  Future<void> getData() async {
    print("object");
    var response = await api_service
        .fetchPost("http://192.168.1.18:4000/stats/calorypercentagebycateory", {
      "user_Id": "6360cf9f0ebc552ba5863f87",
    });
    var d = json.decode(response.body)['message'];
    print(d);

    List<Map> temp = [];

    for (var i = 1; i < 6; i++) {
      print(d[i]);
      temp.add({'category': d[i][0], 'percentage': d[i][1]});
    }

    print(temp);

    setState(() {
      data = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        case "Fruits and Vegetables":
                          return Colors.amber[400];
                        case "Starchy food":
                          return Colors.indigo[400];
                        case "Proteins":
                          return Colors.lightBlue[400];
                        case "Dairy and Fats":
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
                      switch (pieData['domain']) {
                        case "Fruits and Vegetables":
                          return ("Fruits and\nVegetables\n"+
                          pieData['measure'].toString() +
                          '%');
                        case "Starchy food":
                          return pieData['domain'] +
                          '\n' +
                          pieData['measure'].toString() +
                          '%';
                        case "Proteins":
                          return pieData['domain'] +
                          '\n' +
                          pieData['measure'].toString() +
                          '%';
                        case "Dairy and Fats":
                          return "Dairy and\nFats\n"+
                          pieData['measure'].toString() +
                          '%';
                        default:
                          return pieData['domain'] +
                          '\n' +
                          pieData['measure'].toString() +
                          '%';
                      }
                    },
                    showLabelLine: true,
                    strokeWidth: 2,
                  )
                : const Text("Loading"),
          )
        ]),
      ),
    );
  }
}
