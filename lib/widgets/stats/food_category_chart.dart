import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class FoodCategoryChart extends StatelessWidget {
  FoodCategoryChart({super.key});

  final data = [
    {
      'meal': "Breakfast",
      'calpercent': 30,
    },
    {
      'meal': "Lunch",
      'calpercent': 40,
    },
    {
      'meal': "Dinner",
      'calpercent': 30,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [BoxShadow(
          color: Colors.black12 ,
          blurRadius: 25,
          spreadRadius: 10,
        ),]
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 15.0),
        child: Column(
          children: [
          const Text("Calory distribution by Food Category",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              )),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: DChartPie(
              data: data.map((e) {
                return {'domain': e['meal'], 'measure': e['calpercent']};
              }).toList(),
              fillColor: (pieData, index) {
                switch (pieData['domain']) {
                  case "Breakfast":
                    return Colors.teal[400];
                  case "Lunch":
                    return Colors.blue[400];
                  default:
                    return Colors.red[400];
                }
              },
              labelPosition: PieLabelPosition.outside,
              labelColor: Colors.black,
              labelFontSize: 14,
              labelLineColor: Colors.black12,
              labelLineThickness: 2,
              labelLinelength: 16,
              labelPadding: 6,
              pieLabel: (Map<dynamic, dynamic> pieData, int? index){
                return pieData['domain'] + '\n' + pieData['measure'].toString() + '%';
              },
              showLabelLine: true,
              strokeWidth: 2,
            ),
          )
        ]),
      ),
    );
  }
}
