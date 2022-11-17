import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/menuitem.dart';
import 'package:http/http.dart';

class MenuItems {
  static const List<MenuItemDietPlan> nonActive = [itemActivate, itemDelete];
  static const List<MenuItemDietPlan> active = [];

  static const itemActivate =
      MenuItemDietPlan(text: 'Activate', icon: Icons.local_activity_rounded);
  static const itemDelete =
      MenuItemDietPlan(text: 'Delete', icon: Icons.delete);
}
