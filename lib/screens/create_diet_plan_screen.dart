import 'package:flutter/material.dart';

class CreateDietPlanScreen extends StatefulWidget {
  static const routeName = "/addDietPlan";

  @override
  State<CreateDietPlanScreen> createState() => _CreateDietPlanScreenState();
}

class _CreateDietPlanScreenState extends State<CreateDietPlanScreen> {
  String? _selectedMedium;
  String? _selectedDailyActivityLevel;
  String? _selectedDietIntention;
  bool diabitics = false;
  bool bloodPressure = false;
  bool cholestrol = false;

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
                        DropdownButton<String>(
                          value: _selectedMedium,
                          hint: const Text("Gender"),
                          items: <String>['Male', 'Female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedMedium = newValue!;
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
                          value: _selectedMedium,
                          hint: const Text("Gender"),
                          items: <String>['Male', 'Female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedMedium = newValue!;
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
                      vertical: 20,
                      horizontal: 60
                    ),
                    child:
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
                  ),
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
