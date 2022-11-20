import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/foodlist/food_list_button.dart';
import 'package:flutter_application_1/widgets/navigation_drawer.dart';
import '../services/foodlist/foodlist_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  bool currentUser = false;
  static const items = [
    "All Foods",
    "Vegetables",
    "Fruits",
    "Starchy food",
    "Proteins",
    "Dairy",
    "Fats and Sugar",
  ];
  String message = "";
  Map data = {};
  bool loading = true;

  void getData(String id) async {
    var response = await getFoodbyCategory(id);
    if (response is String) {
      setState(() {
        message = response;
      });
    }
    if (response is Map) {
      setState(() {
        data = response;
      });
    }

    setState(() {
      loading = false;
    });
    print(response);
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
      appBar: AppBar(
        title: const Text("Foods in EatSmart"),
        backgroundColor: Colors.green[500],
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.lightGreen[100],
            child: data.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        ...(items).map((type) {
                          return FoodListButton(
                            type: type,
                            data: data[type],
                          );
                        }).toList(),
                      ],
                    ),
                  )
                : loading
                    ? const Center(
                        child: SpinKitSpinningLines(
                          color: Colors.blueGrey,
                          size: 50.0,
                        ),
                      )
                    : Center(
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
          ),
        ),
      ),
    );
  }
}
