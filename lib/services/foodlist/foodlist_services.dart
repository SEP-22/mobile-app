import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'dart:convert';
import 'Food.dart';
import '../../const.dart';

Future<Object> getFoodbyCategory(String id) async {
  var response1 =
      await api_service.fetchGet("${uri}food/allfoods");

  var response2 = await api_service
      .fetchPost("${uri}user/getpreferedfoods", {
    "user_Id": id,
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

    List Vegetables = [];
    List Fruits = [];
    List StarchyFood = [];
    List Protein = [];
    List Dairy = [];
    List FatSugar = [];

    for (var f in fd) {
      switch (f.category) {
        case "Vegetables":
          Vegetables.add(f);
          break;
        case "Fruits":
          Fruits.add(f);
          break;
        case "Starchy food":
          StarchyFood.add(f);
          break;
        case "Proteins":
          Protein.add(f);
          break;
        case "Dairy":
          Dairy.add(f);
          break;
        case "Fats and Sugar":
          FatSugar.add(f);
          break;
        default:
      }
    }

    return {
      'Vegetables': Vegetables,
      'Fruits': Fruits,
      'Starchy food': StarchyFood,
      'Dairy': Dairy,
      'Proteins': Protein,
      'Fats and Sugar': FatSugar,
      'All Foods': fd,
    };
  } else {
    print(response1);
    print(response2);
    return 'Something went Wrong';
  }
}

Future<Object> getAllFoods(String id) async {
  var response1 =
      await api_service.fetchGet("${uri}food/allfoods");

  var response2 = await api_service
      .fetchPost("${uri}user/getpreferedfoods", {
    "user_Id": id,
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
