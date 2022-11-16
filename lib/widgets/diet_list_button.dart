import 'package:flutter/material.dart';

class DietListButton extends StatelessWidget {
  const DietListButton(
      {super.key,
      required this.dietPlanName,
      required this.state,
      required this.dietPlanId});
  final String dietPlanName;
  final bool state;
  final String dietPlanId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 280,
        child: ElevatedButton(
            onPressed: () {
              print(dietPlanName);
              Navigator.pushNamed(context, '/selectedplan', arguments: {
                'planId': dietPlanId,
                'status': state,
                'name': dietPlanName
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
