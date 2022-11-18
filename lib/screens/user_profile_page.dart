import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'package:flutter_application_1/widgets/navigation_drawer.dart';
import 'dart:convert';
import '../const.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<String> profileDetails = ["", "", "", "", ""];
  String id = "6360cf9f0ebc552ba5863f87";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("My Profile"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      drawer: const NavDrawer(),
      body: Container(
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://i.pinimg.com/564x/a6/58/32/a65832155622ac173337874f02b218fb.jpg"))),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                        )),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Text(
                profileDetails[1],
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                          size: 10,
                        )),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Text(
                profileDetails[1],
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
