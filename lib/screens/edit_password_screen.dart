import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/services/editProfile/edit_profile_services.dart';

class EditPassword extends StatefulWidget {
  //const EditPassword({super.key});
  static const routeName = "/editPassword";

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();
  String errorMessage = "";
  bool isError = false;
  String _id = "6360cf9f0ebc552ba5863f87";

  void sendData() async {
    Map data = {};
    data['userId'] = _id;
    data['password'] = passwordController.text.toString();
    var response = await editPassword(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                const Text(
                  "Enter New Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "Password"),
                  controller: passwordController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "Re enter New Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "Password"),
                  controller: repasswordController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.pinkAccent),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 15)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20))))),
                      ElevatedButton(
                          onPressed: () async {
                            //Navigator.of(context).pop(controller.text.toString());
                            setState(() {
                              isError = false;
                            });
                            if (passwordController.text.toString() == "" ||
                                passwordController.text.toString().trim() ==
                                    "" ||
                                repasswordController.text.toString() == "" ||
                                repasswordController.text.toString().trim() ==
                                    "") {
                              setState(() {
                                isError = true;
                                errorMessage = "Password cannot be empty!";
                              });
                            } else if (passwordController.text.toString() !=
                                repasswordController.text.toString()) {
                              setState(() {
                                isError = true;
                                errorMessage = "Passwords doesn't match!";
                              });
                            } else if (passwordController.text
                                    .toString()
                                    .length <
                                8) {
                              setState(() {
                                isError = true;
                                errorMessage =
                                    "Passwords should contain at least 8 letters!";
                              });
                            } else {
                              sendData();
                              Navigator.of(context).pop();
                              await Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (context) => ProfilePage()));
                            }
                          },
                          child: Text("Submit"),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 15)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20))))),
                    ]),
                isError
                    ? Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ))
                    : Text(""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
