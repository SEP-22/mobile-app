import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'dart:convert';
import '../../const.dart';

Future<Object> haveActiveDietPlan() async {
  
  var response = await api_service
      .fetchPost("${uri}user/activeplan", {
    "user_Id": "6360cf9f0ebc552ba5863f87",
  });

  if (response.statusCode == 200) {
    var d = json.decode(response.body)['active'];

    return d;
  } else {
    print(response);
    return 'Something went Wrong';
  }
}

