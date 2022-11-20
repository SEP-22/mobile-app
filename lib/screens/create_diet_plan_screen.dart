import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/utils.dart';
import 'package:flutter_application_1/screens/diet_plan_select_screen.dart';
import 'package:flutter_application_1/screens/selectFoodScreen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../const.dart';

class SelectFoodArguments {
  SelectFoodArguments(
      {required this.addFood,
      required this.removeFood,
      required this.selectedFood});

  final Function addFood;
  final Function removeFood;
  final List<String> selectedFood;
}

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
  final nameController = TextEditingController();

  List<String> seletedFood = [];

  void addFood(String id) {
    seletedFood.add(id);
    print(seletedFood);
  }

  void removeFood(String id) {
    seletedFood.remove(id);
    print(seletedFood);
  }

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

  Future<void> submitPreferedFood(String id) async {
    var response = await api_service.fetchPost(
        "${uri}user/preferedfoods", {"user_Id": id, "foods": seletedFood});
    var data = json.decode(response.body);
    // print(data);
  }

  Future<void> generateDietPlan(String id) async {
    print("rrr");
    var response = await api_service
        .fetchPost("${uri}dietPlan/generatedietplan", {"dietPlan_Id": id});
    var data1 = json.decode(response.body);

    // print(data1["message"]);

    var data = data1["message"].split("}");
    data.removeLast();
    List dietPlan = [];

    for (var element in data) {
      Map obj = {};
      var i1 = element.indexOf(":");
      var i2 = element.indexOf(":", i1 + 1);
      var i3 = element.indexOf("breakfast") + 12;
      var i4 = element.indexOf("lunch") + 8;
      var i5 = element.indexOf("dinner") + 10;
      var dp = element.substring(i1, i2);
      var i = element.substring(i2, i3);
      var br = element.substring(i3, i4).split("],");
      var ln = element.substring(i4, i5).split("],");
      var dn = element.substring(i5).split("],");
      br.removeLast();
      List b = [];
      for (var e in br) {
        var t1 = e.indexOf(",");
        var t2 = e.indexOf(",", t1 + 1);
        var t3 = e.indexOf(",", t2 + 1);
        var t4 = e.indexOf(",", t3 + 1);
        b.add([
          e.substring(e.indexOf("'") + 1, t1 - 1),
          e.substring(t1 + 3, e.indexOf("kcal") + 4),
          e.substring(t2 + 3, e.indexOf("g") + 1),
          e.substring(t3 + 3, t4 - 1),
          e.substring(t4 + 3, e.lastIndexOf("'")),
        ]);
      }
      ln.removeLast();
      List l = [];
      for (var e in ln) {
        var t1 = e.indexOf(",");
        var t2 = e.indexOf(",", t1 + 1);
        var t3 = e.indexOf(",", t2 + 1);
        var t4 = e.indexOf(",", t3 + 1);
        l.add([
          e.substring(e.indexOf("'") + 1, t1 - 1),
          e.substring(t1 + 3, e.indexOf("kcal") + 4),
          e.substring(t2 + 3, e.indexOf("g") + 1),
          e.substring(t3 + 3, t4 - 1),
          e.substring(t4 + 3, e.lastIndexOf("'")),
        ]);
      }
      dn.removeLast();
      List d = [];
      for (var e in dn) {
        var t1 = e.indexOf(",");
        var t2 = e.indexOf(",", t1 + 1);
        var t3 = e.indexOf(",", t2 + 1);
        var t4 = e.indexOf(",", t3 + 1);
        d.add([
          e.substring(e.indexOf("'") + 1, t1 - 1),
          e.substring(t1 + 3, e.indexOf("kcal") + 4),
          e.substring(t2 + 3, e.indexOf("g") + 1),
          e.substring(t3 + 3, t4 - 1),
          e.substring(t4 + 3, e.lastIndexOf("'")),
        ]);
      }
      obj["dietPlan_Id"] = dp.substring(3, dp.indexOf(",") - 1);
      obj["id"] = int.parse(i.substring(2, i.indexOf(",")));
      obj["breakfast"] = b;
      obj["lunch"] = l;
      obj["dinner"] = d;
      dietPlan.add(obj);
    }

    print(dietPlan[0]);

    Navigator.of(context)
        .pushNamed(DietPlanSelectorScreen.routeName, arguments: dietPlan);

    for (var i in dietPlan) {
      // print(i);
    }
  }

  Future<void> submitData(String id) async {
    var active = false;
    var response2 = await api_service.fetchPost("${uri}user/activeplan", {
      "user_Id": id,
    });

    if (response2.statusCode == 200) {
      active = json.decode(response2.body)['active'];
    }

    if (!active && seletedFood.isEmpty) {
      showSnackBar(context, "You should select foods.");
    } else if (!active) {
      var response = await api_service.fetchPost("${uri}dietPlan/quiz", {
        "user_Id": id,
        "name": nameController.text,
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
      print(seletedFood);

      print(seletedFood.length > 0);
      if (seletedFood.length > 0) {
        submitPreferedFood(id);
      }

      generateDietPlan(data["_id"]);

      var response3 = await api_service.fetchPost("${uri}user/updateactiveplan",
          {'user_Id': id, "activePlan_Id": data["_id"]});
    } else {
      var response = await api_service.fetchPost("${uri}dietPlan/quiz", {
        "user_Id": id,
        "name": nameController.text,
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

      if (seletedFood.length > 0) {
        submitPreferedFood(id);
      }

      generateDietPlan(data["_id"]);
    }

    // print(data);
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      color: Colors.black87,
    ),
    backgroundColor: const Color(0xfff178b6),
    minimumSize: const Size(120, 50),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
    ),
  );

  final choosedateButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    print(user.id);
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
          padding: const EdgeInsets.symmetric(
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
                        vertical: 20, horizontal: 50),
                    child: Column(
                      children: [
                        const Text(
                          "Diet Plan Name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: const InputDecoration(hintText: "Name"),
                          controller: nameController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
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
                          "Enter Your Birthday",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 70,
                          child: Column(
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "No Date Choosen!"
                                    : DateFormat.yMd().format(_selectedDate!),
                              ),
                              ElevatedButton(
                                onPressed: _presentDatePicker,
                                style: choosedateButtonStyle,
                                child: const Text(
                                  "Choose Date",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xfff178b6)),
                                ),
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
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButton<String>(
                          value: _selectedGender,
                          hint: const Text("Gender"),
                          items: <String>['Male', 'Female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
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
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: const InputDecoration(hintText: "Height"),
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
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: const InputDecoration(hintText: "Weight"),
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
                        const SizedBox(
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
                        const SizedBox(
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
                              child: Text(value),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 40,
                            ), //SizedBox
                            const Text(
                              'Diabitics: ',
                              style: TextStyle(fontSize: 17.0),
                            ), //Text
                            const SizedBox(width: 10), //SizedBox
                            /** Checkbox Widget **/
                            Checkbox(
                              value: diabitics,
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
                            const SizedBox(
                              width: 40,
                            ), //SizedBox
                            const Text(
                              'High Blood Pressure: ',
                              style: TextStyle(fontSize: 17.0),
                            ), //Text
                            const SizedBox(width: 10), //SizedBox
                            /** Checkbox Widget **/
                            Checkbox(
                              value: bloodPressure,
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
                            const SizedBox(
                              width: 40,
                            ), //SizedBox
                            const Text(
                              'Cholestrol: ',
                              style: TextStyle(fontSize: 17.0),
                            ), //Text
                            const SizedBox(width: 10), //SizedBox
                            /** Checkbox Widget **/
                            Checkbox(
                              value: cholestrol,
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
                        style: choosedateButtonStyle,
                        onPressed: () {
                          Navigator.of(context).pushNamed(FoodScreen.routeName,
                              arguments: SelectFoodArguments(
                                  addFood: addFood,
                                  removeFood: removeFood,
                                  selectedFood: seletedFood));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.food_bank,
                              color: Color(0xfff178b6),
                              size: 40,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Select Foods',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xfff178b6)),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  submitData(user.id);
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
