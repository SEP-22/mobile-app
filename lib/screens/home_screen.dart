import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/navigation_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           title: const Text("Home"),
        backgroundColor: Colors.green[500],     
      ),
      drawer: NavDrawer(),
      body: Text("home"),
    );
  }
}