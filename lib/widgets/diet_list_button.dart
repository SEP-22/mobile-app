import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DietListButton extends StatelessWidget {
  const DietListButton({super.key, required this.dietPlanName});
  final String dietPlanName;
  //final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 280,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            //minimumSize: Size(280, 70),
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Text(
            dietPlanName,
            style: const TextStyle(color: Colors.black, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
