import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'dart:convert';
import '../../const.dart';

Future<Object> getAllPlanNamesAndStateByUserId(String id) async {
  var response = await api_service
      .fetchGet("${uri}dietPlan/getAllPlanNamesAndStateByUserId/$id");
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //print("list fetched");
    //print(data);
    return data;
  } else {
    return 'Something went wrong';
  }
}
