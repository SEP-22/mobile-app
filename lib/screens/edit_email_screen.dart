import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/services/editProfile/edit_profile_services.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class EditEmail extends StatefulWidget {
  //const EditEmail({super.key});
  static const routeName = "/editemail";

  @override
  State<EditEmail> createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  final emailController = TextEditingController();
  RegExp regExEmail = RegExp(
      r'[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$');

  String errorMessage = "";
  bool isError = false;
  //String _id = "6360cf9f0ebc552ba5863f87";

  Future<bool> sendData(String userId) async {
    Map data = {};
    data['userId'] = userId;
    data['email'] = emailController.text.toString();
    var response = await editEmail(data);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Email"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Column(
            children: [
              const Text(
                "Enter Your Email Address",
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
                controller: emailController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 15)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))))),
                ElevatedButton(
                    onPressed: () async {
                      //Navigator.of(context).pop(controller.text.toString());
                      setState(() {
                        isError = false;
                      });
                      if (emailController.text.toString() == "" ||
                          emailController.text.toString().trim() == "") {
                        setState(() {
                          isError = true;
                          errorMessage = "Email Address cannot be empty!";
                        });
                      } else if (!regExEmail
                          .hasMatch(emailController.text.toString())) {
                        setState(() {
                          isError = true;
                          errorMessage = "Please enter a valid email address!";
                        });
                      } else {
                        bool state = await sendData(user.id);
                        if (state) {
                          Navigator.of(context).pop();
                          await Navigator.of(context).push(
                              new MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        } else {
                          setState(() {
                            isError = true;
                            errorMessage =
                                "The email you entered is already in use!";
                          });
                        }
                      }
                    },
                    child: Text("Submit"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 15)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))))),
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
    );
  }
}
