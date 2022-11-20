import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/services/dietPlan/dietplan_list_services.dart';
import 'package:flutter_application_1/widgets/diet_list_button.dart';
import 'package:flutter_application_1/widgets/mealButton.dart';
import 'package:flutter_application_1/widgets/navigation_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class DietPlanListScreen extends StatefulWidget {
  const DietPlanListScreen({super.key});
  static const routeName = "/dietplanlist";

  @override
  State<DietPlanListScreen> createState() => _DietPlanListScreenState();
}

class _DietPlanListScreenState extends State<DietPlanListScreen> {
  String message = "Loading...";
  Map data = {};
  bool loading = true;
  List<String> dietIdList = [];
  bool? currentUser = false;

  void getData(String userId) async {
    print(userId);
    var response = await getAllPlanNamesAndStateByUserId(userId);
    if (response is String) {
      setState(() {
        message = response;
      });
    }
    if (response is Map) {
      setState(() {
        data = response;
        data.forEach((k, v) => dietIdList.add(k));
      });
    }
    setState(() {
      loading = false;
    });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    if (currentUser == false) {
      getData(user.id);
      setState(() {
        currentUser = true;
      });
    }
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        title: const Text("My Diet Plans"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.lightGreen[100],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  children: data.isNotEmpty
                      ? dietIdList.map((String value) {
                          return DietListButton(
                            dietPlanName: data[value][0],
                            state: data[value][1],
                            dietPlanId: value,
                          );
                        }).toList()
                      : [
                          Center(
                              child: Text(
                            message,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 2,
                              wordSpacing: 10,
                            ),
                          )),
                        ]),
            ),
          ),
        ),
      ),
    );
  }
}
