import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/dietPlan/dietplan_services.dart';

class DietListButton extends StatelessWidget {
  const DietListButton(
      {super.key,
      required this.dietPlanName,
      required this.state,
      required this.dietPlanId});
  final String dietPlanName;
  final bool state;
  final String dietPlanId;
  //late String whatever;
  //late Map whatever2;

  // void getData() async {
  //   //var temp_dietPlanDetails = new Map();
  //   print(dietPlanId);
  //   var response = await getDietPlanById(dietPlanId);
  //   if (response is String) {
  //     whatever = response;
  //     whatever2 = {};
  //   }
  //   if (response is Map) {
  //     whatever2 = response;
  //     whatever = "";
  //   }

  //   //print("here");
  //   //print(data);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 280,
        child: ElevatedButton(
            onPressed: () {
              //getData();
              //print(whatever2);
              Navigator.pushNamed(context, '/selectedplan', arguments: {
                'planId': dietPlanId,
                'status': state,
                'name': dietPlanName,
              });
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 70),
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            child: state
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                          dietPlanName,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Icon(
                          Icons.verified,
                          color: Colors.pinkAccent,
                        )
                      ])
                : Text(
                    dietPlanName,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    textAlign: TextAlign.center,
                  )),
      ),
    );
  }
}
