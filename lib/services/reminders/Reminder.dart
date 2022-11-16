import 'package:flutter/material.dart';

class Reminder {
  final String id;
  final TimeOfDay breakfastTime;
  final TimeOfDay lunchTime;
  final TimeOfDay dinnerTime;
  final bool breakfastOn;
  final bool lunchOn;
  final bool dinnerOn;

  Reminder({
    required this.id,
    required this.breakfastTime,
    required this.lunchTime,
    required this.dinnerTime,
    required this.breakfastOn,
    required this.lunchOn,
    required this.dinnerOn,
  });
}
