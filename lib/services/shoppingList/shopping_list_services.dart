// import 'package:flutter/cupertino.dart';
// import 'package:flutter_application_1/services/api_service.dart' as api_service;
// import 'dart:convert';
// import '../../const.dart';

// Future<Object> getShoppingLists(userId) async {
//   List<String> temp_shoppingListNames = [];
//   var temp_map = new Map();
//   //food template data

//   var response = await api_service
//       .fetchGet("${uri}shoppingList/getShoppingListsFromUserId/$userId");
//   print("shoppingList taken");
//   var data = json.decode(response.body);
//   for (var shoppingList in data) {
//       temp_shoppingListNames.add(shoppingList[0]);
//       temp_map[shoppingList[0]] = [shoppingList[2], shoppingList[1]];
//     }
//     print(temp_shoppingListNames);
//     print(temp_map);

//     setState(() {
//       shoppingListNames = temp_shoppingListNames;
//       slMap = temp_map;
//     });
// }
