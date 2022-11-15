import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'dart:convert';
import 'Food.dart';

Future<Object> getFoodbyCategory() async {
  var response1 =
      await api_service.fetchGet("http://192.168.8.104:4000/food/allfoods");

  var response2 = await api_service
      .fetchPost("http://192.168.8.104:4000/user/getpreferedfoods", {
    "user_Id": "6360cf9f0ebc552ba5863f87",
  });

  if (response1.statusCode == 200 && response2.statusCode == 200) {
    var d = json.decode(response1.body);
    var preffered = json.decode(response2.body)["preferedFoods"];

    print(d);

    for (var key in d[0].keys) {
      print(key);
      print(d[0][key].runtimeType);
    }

    List fd = [];
    for (var element in d) {
      fd.add(Food(
          id: element["_id"],
          name: element["name"],
          category: element["category"],
          image: element["image"],
          diabetics: element["diabetics"],
          cholesterol: element["cholesterol"],
          bloodpressure: element["bloodpressure"],
          cal_per_gram: element["cal_per_gram"] is double? element["cal_per_gram"]:element["cal_per_gram"].toDouble() ,
          protein: element["protein"] is double? element["protein"]:element["protein"].toDouble(),
          fat: element["fat"] is double? element["fat"]:element["fat"].toDouble(),
          fiber: element["fiber"] is double? element["fiber"]:element["fiber"].toDouble(),
          carbs: element["carbs"] is double? element["carbs"]:element["carbs"].toDouble(),
      ));
    }

    for (var f in fd) {
      if (preffered.contains(f.id)) {
        f.setSelected();
      }
    }

    List FruitsVegetables = [];
    List StarchyFood = [];
    List Protein = [];
    List DairyFat = [];
    List Sugar = [];

    for (var f in fd) {
      switch (f.category) {
        case "Fruits and Vegetables":
          FruitsVegetables.add(f);
          break;
        case "Starchy food":
          StarchyFood.add(f);
          break;
        case "Proteins":
          Protein.add(f);
          break;
        case "Dairy and Fats":
          DairyFat.add(f);
          break;
        case "Sugar":
          Sugar.add(f);
          break;
        default:
      }
    }

    return {
      'Fruits and Vegetables': FruitsVegetables,
      'Starchy food': StarchyFood,
      'Dairy and Fats': DairyFat,
      'Proteins': Protein,
      'Sugar': Sugar,
      'All Foods': fd,
    };
  } else {
    print(response1);
    print(response2);
    return 'Something went Wrong';
  }
}

Future<Object> getAllFoods() async {
  var response1 =
      await api_service.fetchGet("http://192.168.8.104:4000/food/allfoods");

  var response2 = await api_service
      .fetchPost("http://192.168.8.104:4000/user/getpreferedfoods", {
    "user_Id": "6360cf9f0ebc552ba5863f87",
  });

  if (response1.statusCode == 200 && response2.statusCode == 200) {
    var d = json.decode(response1.body);
    var preffered = json.decode(response2.body)["preferedFoods"];

    List fd = [];
    for (var element in d) {
      fd.add(Food(
          id: element["_id"],
          name: element["name"],
          category: element["category"],
          image: element["image"],
          diabetics: element["diabetics"],
          cholesterol: element["cholesterol"],
          bloodpressure: element["bloodpressure"],
          cal_per_gram: element["cal_per_gram"],
          protein: element["protein"],
          fat: element["fat"],
          fiber: element["fiber"],
          carbs: element["carbs"]));
    }

    for (var f in fd) {
      if (preffered.contains(f.id)) {
        f.setSelected();
      }
    }

    return fd;
  } else {
    print(response1);
    print(response2);
    return 'Something went Wrong';
  }
}
