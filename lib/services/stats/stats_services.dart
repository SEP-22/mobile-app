import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'dart:convert';

Future<Object> getMostOccuringFoods() async {
  var response = await api_service
      .fetchPost("http://192.168.8.101:4000/stats/maxcountfoodsinDP", {
    "user_Id": "6360cf9f0ebc552ba5863f87",
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

Future<Object> getFoodCategoryPercentage() async {
  var response = await api_service
      .fetchPost("http://192.168.8.101:4000/stats/calorypercentagebycateory", {
    "user_Id": "6360cf9f0ebc552ba5863f87",
  });

  if (response.statusCode == 200) {
    var d = json.decode(response.body)['message'];

    List<Map> temp = [];

    for (var i = 1; i < 6; i++) {
      temp.add({'category': d[i][0], 'percentage': d[i][1]});
    }
    return temp;
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

Future<Object> haveActiveDietPlan() async {
  
  var response = await api_service
      .fetchPost("http://192.168.8.101:4000/user/activeplan", {
    "user_Id": "6360cf9f0ebc552ba5863f87",
  });

  if (response.statusCode == 200) {
    var d = json.decode(response.body)['active'];
    print(d);
    return d;
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

