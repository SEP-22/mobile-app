import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'dart:convert';
import '../../const.dart';

Future<bool> editName(data) async {
  var response = await api_service.fetchPost('${uri}user/editName', data);
  if (response.statusCode == 200) {
    print("name edited");
    return true;
  } else {
    return false;
  }
}

Future<bool> editPhone(data) async {
  var response = await api_service.fetchPost('${uri}user/editPhone', data);
  if (response.statusCode == 200) {
    print("phone edited");
    return true;
  } else {
    return false;
  }
}

Future<bool> editPassword(data) async {
  var response = await api_service.fetchPost('${uri}user/editPassword', data);
  if (response.statusCode == 200) {
    print("password edited");
    return true;
  } else {
    print(response.body);
    return false;
  }
}

Future<bool> editEmail(data) async {
  var response = await api_service.fetchPost('${uri}user/editEmail', data);
  if (response.statusCode == 200) {
    print("email edited");
    return true;
  } else {
    print(response.body);
    return false;
  }
}
