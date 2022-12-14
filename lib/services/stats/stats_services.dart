import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'dart:convert';
import '../../const.dart';

Future<Object> getMostOccuringFoods(String id) async {
  var response = await api_service
      .fetchPost("${uri}stats/maxcountfoodsinDP", {
    "user_Id": id,
  });

  if (response.statusCode == 200) {
    var d = json.decode(response.body)['message'];
    if (d.contains('[[')) {
      var arr = d.split(']');
      arr.removeLast();
      arr.removeLast();
      List fd = [];
      for (var i = 0; i < arr.length; i++) {
        var temp;
        if (i > 0) {
          temp = arr[i].substring(arr[i].indexOf(",") + 1).split(",");
        } else {
          temp = arr[i].split(",");
        }

        List t = [];
        for (var e in temp) {
          t.add(e.substring(e.indexOf("'") + 1, e.lastIndexOf("'")));
        }

        fd.add(t);
      }
      return fd;
    } else {
      return d;
    }
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

Future<Object> getFoodCategoryPercentage(String id) async {
  var response = await api_service
      .fetchPost("${uri}stats/calorypercentagebycateory", {
    "user_Id": id,
  });

  if (response.statusCode == 200) {
    var d = json.decode(response.body)['message'];

    List<Map> temp = [];

    for (var i = 1; i < 7; i++) {
      temp.add({'category': d[i][0], 'percentage': d[i][1]});
    }
    return temp;
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

Future<Object> haveActiveDietPlan(String id) async {
  
  var response = await api_service
      .fetchPost("${uri}user/activeplan", {
    "user_Id": id,
  });

  if (response.statusCode == 200) {
    var d = json.decode(response.body)['active'];

    return d;
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

