library api_service;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

Future<http.Response> fetchGet(String path) async {
  final response = await http.get(Uri.parse(path), headers: headers);
  return response;
}

Future<http.Response> fetchPost(String path, Object body) async {
  var encodeBody = json.encode(body);
  final response =
      await http.post(Uri.parse(path), body: encodeBody, headers: headers);
  return response;
}

Future<http.Response> fetchPut(String path, Object body) async {
  var encodeBody = json.encode(body);
  final response =
      await http.put(Uri.parse(path), body: encodeBody, headers: headers);

  return response;
}

Future<http.Response> fetchDelete(String params) async {
  final response = await http.delete(Uri.parse(params), headers: headers);
  return response;
}
