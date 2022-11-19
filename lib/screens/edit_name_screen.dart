import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/services/editProfile/edit_profile_services.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class EditName extends StatefulWidget {
  //const EditName({super.key});
  static const routeName = "/editname";

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  final nameController = TextEditingController();
  String errorMessage = "";
  bool isError = false;
  //String _id = "6360cf9f0ebc552ba5863f87";

  void sendData(String userId) async {
    Map data = {};
    data['userId'] = userId;
    data['name'] = nameController.text.toString();
    var response = await editName(data);
    if (response) {
      Navigator.of(context).pop();
      await Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Name"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Column(
            children: [
              const Text(
                "Enter Your Name",
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
                      if (nameController.text.toString() == "" ||
                          nameController.text.toString().trim() == "") {
                        setState(() {
                          isError = true;
                          errorMessage = "Name cannot be empty!";
                        });
                      } else {
                        sendData(user.id);
                        // Navigator.of(context).pop();
                        // await Navigator.of(context).push(new MaterialPageRoute(
                        //     builder: (context) => ProfilePage()));
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
