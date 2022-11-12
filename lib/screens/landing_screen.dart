import 'package:flutter_application_1/screens/create_diet_plan_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eat Smart"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.grey[300],
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            color: Colors.white,
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                // ignore: sort_child_properties_last
                children: [
                  const Text(
                    "Welcome\n to\n EAT SMART",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    child: Image.network(
                      "https://img.freepik.com/premium-vector/nutritionist-makes-diet-plan-mobile-application-online-nutrition-consultation-concept-cartoon-vector-illustration_319667-323.jpg",
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(CreateDietPlanScreen.routeName);
                    },
                    child: Text('TextButton'),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
