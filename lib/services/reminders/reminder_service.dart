import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'package:flutter_application_1/services/reminders/Reminder.dart';
import 'dart:convert';
import '../../const.dart';
import 'Reminder.dart';

Future<Object> getReminder() async {
  var response = await api_service.fetchPost("${uri}reminder/getreminder", {
    "user_Id": "6374ace858f6e3309980503a",
  });

  if (response.statusCode == 200) {
    var d = json.decode(response.body)[0];

    Reminder r = Reminder(
      id: d["_id"].toString(),
      breakfastTime: TimeOfDay(
          hour: d["breakfastHour"] is int
              ? d["breakfastHour"]
              : int.parse(d["breakfastHour"]),
          minute: d["breakfastMinute"] is int
              ? d["breakfastMinute"]
              : int.parse(d["breakfastMinute"])),
      lunchTime: TimeOfDay(
          hour: d["lunchHour"] is int
              ? d["lunchHour"]
              : int.parse(d["lunchHour"]),
          minute: d["lunchMinute"] is int
              ? d["lunchMinute"]
              : int.parse(d["lunchMinute"])),
      dinnerTime: TimeOfDay(
          hour: d["dinnerHour"] is int
              ? d["dinnerHour"]
              : int.parse(d["dinnerHour"]),
          minute: d["dinnerMinute"] is int
              ? d["dinnerMinute"]
              : int.parse(d["dinnerMinute"])),
      breakfastOn: d["breakfastOn"],
      lunchOn: d["lunchOn"],
      dinnerOn: d["dinnerOn"],
    );

    return r;
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

Future<String> updateBreakfast(String id, TimeOfDay time, bool br) async {
  var response = await api_service.fetchPost("${uri}reminder/updatebreakfast", {
    "_id": id,
    "breakfastMinute": time.minute,
    "breakfastHour": time.hour,
    "breakfastOn": br,
  });

  if (response.statusCode == 200) {
    return 'success';
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

Future<String> updateLunch(String id, TimeOfDay time, bool br) async {
  var response = await api_service.fetchPost("${uri}reminder/updatelunch", {
    "_id": id,
    "lunchMinute": time.minute,
    "lunchHour": time.hour,
    "lunchOn": br,
  });

  if (response.statusCode == 200) {
    return 'success';
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

Future<String> updateDinner(String id, TimeOfDay time, bool br) async {
  var response = await api_service.fetchPost("${uri}reminder/updatedinner", {
    "_id": id,
    "dinnerMinute": time.minute,
    "dinnerHour": time.hour,
    "dinnerOn": br,
  });

  if (response.statusCode == 200) {
    return 'success';
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

Future<String> cancelDBBreakfast(String id) async {
  var response = await api_service.fetchPost("${uri}reminder/updatebreakfast", {
    "_id": id,
    "breakfastOn": false,
  });

  if (response.statusCode == 200) {
    return 'success';
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

Future<String> cancelDBLunch(String id) async {
  var response = await api_service.fetchPost("${uri}reminder/updatelunch", {
    "_id": id,
    "lunchOn": false,
  });

  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return 'success';
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

Future<String> cancelDBDinner(String id) async {
  var response = await api_service.fetchPost("${uri}reminder/updatedinner", {
    "_id": id,
    "dinnerOn": false,
  });

  if (response.statusCode == 200) {
    return 'success';
  } else {
    print(response);
    return 'Something went Wrong';
  }
}
