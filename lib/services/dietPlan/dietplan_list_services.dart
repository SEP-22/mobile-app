import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'dart:convert';
import '../../const.dart';

Future<Object> getAllPlanNamesAndStateByUserId() async {
  var response = await api_service.fetchGet(
      "${uri}dietPlan/getAllPlanNamesAndStateByUserId/6360cf9f0ebc552ba5863f87");
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //print("list fetched");
    //print(data);
    return data;
  } else {
    return 'Something went wrong';
  }
}
