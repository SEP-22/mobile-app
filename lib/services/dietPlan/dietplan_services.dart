import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'dart:convert';
import '../../const.dart';

import 'package:flutter_application_1/widgets/complete_food_item.dart';

Future<Object> getDietPlanById(String id) async {
  //String path = "http://192.168.1.9:4000/dietPlan/getWeeklyDietPlanById/";
  // var response = await api_service.fetchGet(
  //     "http://192.168.1.9:4000/dietPlan/getWeeklyDietPlan/active/6360cf9f0ebc552ba5863f87");
  var response =
      await api_service.fetchGet('${uri}dietPlan/getWeeklyDietPlanById/$id');
  if (response.statusCode == 200) {
    print("active plan taken");
    var data = json.decode(response.body);
    //print(data[0][2][0]);

    Map formattedData = {};

    formattedData['_id'] = data[0][0];
    formattedData['name'] = data[0][1];
    var count = 0;
    //monday
    for (var eachDayElem in data[0][2]) {
      // List breakfastWidgets = [];
      // List lunchWidgets = [];
      // List dinnerWidgets = [];
      List<Widget> breakfastWidgets = [];
      List<Widget> lunchWidgets = [];
      List<Widget> dinnerWidgets = [];

      for (var bfElem in eachDayElem[0]) {
        //breakfastWidgets.add([bfElem[4], bfElem[3], bfElem[2], bfElem[1]]);
        breakfastWidgets
            .add(CompleteFoodItem(bfElem[4], bfElem[3], bfElem[2], bfElem[1]));
      }
      for (var lunchElem in eachDayElem[1]) {
        //lunchWidgets.add([lunchElem[4], lunchElem[3], lunchElem[2], lunchElem[1]]);
        lunchWidgets.add(CompleteFoodItem(
            lunchElem[4], lunchElem[3], lunchElem[2], lunchElem[1]));
      }
      for (var dinnerElem in eachDayElem[2]) {
        //dinnerWidgets.add([dinnerElem[4], dinnerElem[3], dinnerElem[2], dinnerElem[1]]);
        dinnerWidgets.add(CompleteFoodItem(
            dinnerElem[4], dinnerElem[3], dinnerElem[2], dinnerElem[1]));
      }
      formattedData[count] = [breakfastWidgets, lunchWidgets, dinnerWidgets];
      count += 1;
    }

    return formattedData;
  } else {
    return "Something Went Wrong";
  }
}