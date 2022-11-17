import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'package:flutter_application_1/widgets/navigation_drawer.dart';
import 'dart:convert';
import '../const.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> profileDetails = ["","","","",""];
  String id = "6335d3887e7aaea82d5e3654";

  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  Future<void> getProfileDetails() async {
    List<String> temp_profile_details = [];

    var response =
        await api_service.fetchGet("${uri}user/profileDetails/6360cf9f0ebc552ba5863f87");
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: const Text("My Profile"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      drawer: NavDrawer(),
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://i.pinimg.com/564x/a6/58/32/a65832155622ac173337874f02b218fb.jpg'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Color(0xfff178b6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              buildTextField("Name", profileDetails[1]),
              buildTextField("Email", profileDetails[2]),
              buildTextField("Phone Number", profileDetails[4]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 35),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
