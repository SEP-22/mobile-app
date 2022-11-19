import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'package:flutter_application_1/widgets/navigation_drawer.dart';
import 'package:flutter_application_1/widgets/profile_detail.dart';
import 'dart:convert';
import '../const.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> profileDetails = ["", "", "", "", ""];
  String id = "6360cf9f0ebc552ba5863f87";
  bool isObscure = true;
  TextEditingController controller = TextEditingController();
  String errorMessage = "";
  bool isError = false;

  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  Future<void> getProfileDetails() async {
    List<String> temp_profile_details = [];

    var response = await api_service.fetchGet("${uri}user/profileDetails/$id");
    print("Im here");
    var data = json.decode(response.body);
    temp_profile_details.add(data["_id"]);
    temp_profile_details.add(data["name"]);
    temp_profile_details.add(data["email"]);
    temp_profile_details.add(data["password"]);
    temp_profile_details.add(data["phone"]);
    setState(() {
      profileDetails = temp_profile_details;
    });
  }

  // Future<dynamic> createAlertDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text("Edit Name"),
  //           content: TextField(
  //             controller: controller,
  //           ),
  //           actions: <Widget>[
  //             ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text("Cancel"),
  //                 style: ButtonStyle(
  //                     backgroundColor:
  //                         MaterialStateProperty.all(Colors.pinkAccent),
  //                     padding: MaterialStateProperty.all(
  //                         const EdgeInsets.fromLTRB(15, 10, 15, 10)),
  //                     textStyle:
  //                         MaterialStateProperty.all(TextStyle(fontSize: 15)),
  //                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(20))))),
  //             ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(controller.text.toString());
  //                 },
  //                 child: Text("Submit"),
  //                 style: ButtonStyle(
  //                     backgroundColor: MaterialStateProperty.all(Colors.green),
  //                     padding: MaterialStateProperty.all(
  //                         const EdgeInsets.fromLTRB(15, 10, 15, 10)),
  //                     textStyle:
  //                         MaterialStateProperty.all(TextStyle(fontSize: 15)),
  //                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(20))))),
  //           ],
  //         );
  //       });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("My Profile"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 600,
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://i.pinimg.com/564x/a6/58/32/a65832155622ac173337874f02b218fb.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  "Name",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Text(
                          profileDetails[1],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ]),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/editname',
                                arguments: {'userId': profileDetails[0]});
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.pinkAccent,
                          )),
                    ]),
              ),
              const Divider(
                color: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  "Email",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Text(
                          profileDetails[2],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ]),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/editemail',
                                arguments: {'userId': profileDetails[0]});
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.pinkAccent,
                          )),
                    ]),
              ),
              const Divider(
                color: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  "Phone",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Text(
                          profileDetails[4],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ]),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/editphone',
                                arguments: {'userId': profileDetails[0]});
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.pinkAccent,
                          )),
                    ]),
              ),
              const Divider(
                color: Colors.grey,
              ),
              // const Padding(
              //   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              //   child: Text(
              //     "Password",
              //     style: TextStyle(color: Colors.blueGrey, fontSize: 15),
              //     textAlign: TextAlign.left,
              //   ),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              //   child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Column(children: [
              //           Text(
              //             isObscure
              //                 ? profileDetails[4].replaceAll(RegExp(r"."), "*")
              //                 : profileDetails[4],
              //             style: const TextStyle(
              //                 color: Colors.black, fontSize: 20),
              //             textAlign: TextAlign.left,
              //           ),
              //         ]),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: isObscure
              //               ? [
              //                   IconButton(
              //                       onPressed: () {
              //                         setState(() {
              //                           isObscure = false;
              //                         });
              //                         print(isObscure);
              //                       },
              //                       icon: const Icon(
              //                         Icons.visibility_off,
              //                         color: Colors.grey,
              //                       )),
              //                   IconButton(
              //                       onPressed: () {},
              //                       icon: const Icon(
              //                         Icons.edit,
              //                         color: Colors.pinkAccent,
              //                       )),
              //                 ]
              //               : [
              //                   IconButton(
              //                       onPressed: () {
              //                         setState(() {
              //                           isObscure = true;
              //                         });
              //                         print(isObscure);
              //                       },
              //                       icon: const Icon(
              //                         Icons.visibility_sharp,
              //                         color: Colors.grey,
              //                       )),
              //                   IconButton(
              //                       onPressed: () {},
              //                       icon: const Icon(
              //                         Icons.edit,
              //                         color: Colors.pinkAccent,
              //                       )),
              //                 ],
              //         ),
              //       ]),
              // ),
              // const Divider(
              //   color: Colors.grey,
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(
                  child: ElevatedButton.icon(
                      label: Text("Edit password"),
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(context, '/editPassword',
                            arguments: {'userId': profileDetails[0]});
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pinkAccent),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 15)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
