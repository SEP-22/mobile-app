import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/selectFoodScreen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;

class CreateDietPlanScreen extends StatefulWidget {
  static const routeName = "/addDietPlan";

  @override
  State<CreateDietPlanScreen> createState() => _CreateDietPlanScreenState();
}

class _CreateDietPlanScreenState extends State<CreateDietPlanScreen> {
  String? _selectedGender;
  String? _selectedDailyActivityLevel;
  String? _selectedDietIntention;
  bool diabitics = false;
  bool bloodPressure = false;
  bool cholestrol = false;
  DateTime? _selectedDate;
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Future<void> submitData() async {
    var response =
        await api_service.fetchPost("http://10.0.2.2:4000/dietPlan/quiz", {
      "user_Id": "63368984ba7e4ea7b42b792b",
      "dob": _selectedDate!.toIso8601String(),
      "gender": _selectedGender!.toLowerCase(),
      "activity":
          _selectedDailyActivityLevel!.toLowerCase().replaceAll(" ", ""),
      "intention": _selectedDietIntention!.toLowerCase().split(" ")[0],
      "height": heightController.text,
      "weight": weightController.text,
      "diabetics": diabitics,
      "cholesterol": cholestrol,
      "bloodpressure": bloodPressure,
    });
    var data = json.decode(response.body);
    print(data);
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.pink[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: false,
        title: const Text(
          "Create Your Diet Plan",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 1,
            horizontal: 20,
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Enter Your Birthday",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 70,
                          child: Column(
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "No Date Choosen!"
                                    : "${DateFormat.yMd().format(_selectedDate!)}",
                              ),
                              ElevatedButton(
                                onPressed: _presentDatePicker,
                                child: Text(
                                  "Choose Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                style: raisedButtonStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Select Your Gender",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButton<String>(
                          value: _selectedGender,
                          hint: const Text("Gender"),
                          items: <String>['Male', 'Female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedGender = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 100),
                    child: Column(
                      children: [
                        const Text(
                          "Height (cm)",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Height"),
                          controller: heightController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 100),
                    child: Column(
                      children: [
                        const Text(
                          "Weight (kg)",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Weight"),
                          controller: weightController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Select Your Daily Activity Level",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButton<String>(
                          value: _selectedDailyActivityLevel,
                          hint: const Text("Daily Activity Level"),
                          items: <String>[
                            'Very Light',
                            'Light',
                            "Moderate",
                            "Heavy",
                            "Very Heavy"
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedDailyActivityLevel = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Select Your Diet Intention",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButton<String>(
                          value: _selectedDietIntention,
                          hint: const Text("Diet Intention"),
                          items: <String>[
                            'Loose Weight',
                            "Maintain Weight",
                            'Gain Weight'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedDietIntention = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Select if you have following illnesses",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 40,
                            ), //SizedBox
                            Text(
                              'Diabitics: ',
                              style: TextStyle(fontSize: 17.0),
                            ), //Text
                            SizedBox(width: 10), //SizedBox
                            /** Checkbox Widget **/
                            Checkbox(
                              value: this.diabitics,
                              onChanged: (diabitics) {
                                setState(() {
                                  this.diabitics = diabitics!;
                                });
                              },
                            ), //Checkbox
                          ], //<Widget>[]
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 40,
                            ), //SizedBox
                            Text(
                              'High Blood Pressure: ',
                              style: TextStyle(fontSize: 17.0),
                            ), //Text
                            SizedBox(width: 10), //SizedBox
                            /** Checkbox Widget **/
                            Checkbox(
                              value: this.bloodPressure,
                              onChanged: (bloodPressure) {
                                setState(() {
                                  this.bloodPressure = bloodPressure!;
                                });
                              },
                            ), //Checkbox
                          ], //<Widget>[]
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 40,
                            ), //SizedBox
                            Text(
                              'Cholestrol: ',
                              style: TextStyle(fontSize: 17.0),
                            ), //Text
                            SizedBox(width: 10), //SizedBox
                            /** Checkbox Widget **/
                            Checkbox(
                              value: this.cholestrol,
                              onChanged: (cholestrol) {
                                setState(() {
                                  this.cholestrol = cholestrol!;
                                });
                              },
                            ), //Checkbox
                          ], //<Widget>[]
                        ) //Row
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 60),
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          Navigator.of(context).pushNamed(FoodScreen.routeName);
                        },
                        child: Text(
                          'Select Foods',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
