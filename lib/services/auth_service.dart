import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/landing_screen.dart';
import 'package:flutter_application_1/widgets/bottom_bar.dart';
import 'package:flutter_application_1/constants/error_handling.dart';
import 'package:flutter_application_1/constants/global_variables.dart';
import 'package:flutter_application_1/constants/utils.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/services/api_service.dart' as api_service;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      print("In sign up method.");
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        phone: phone,
        role: 'user',
        token: '',
      );

      // http.Response res1 =
      //     await http.post(Uri.parse('${uri}user/singleEmail/${email}'));

      // print(jsonDecode(res1.body));

      var response =
          await api_service.fetchGet("${uri}user/singleEmail/${email}");

      if (jsonDecode(response.body).isNotEmpty) {
        showSnackBar(
          context,
          'Email is already registerd!',
        );
      } else {
        http.Response res = await http.post(
          Uri.parse('${uri}user/signUp'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (jsonDecode(res.body).isNotEmpty) {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        }
      }

      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     print("succ");
      //     showSnackBar(
      //       context,
      //       'Account created! Login with the same credentials!',
      //     );
      //   },
      // );
    } catch (e) {
      print(e);
      // showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${uri}user/signIn'),
        body: jsonEncode({
          'username': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (jsonDecode(res.body)["user"] == null) {
        showSnackBar(context, jsonDecode(res.body)["message"]);
      }
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print(jsonEncode(jsonDecode(res.body)["user"]));
          Provider.of<UserProvider>(context, listen: false)
              .setUser(jsonEncode(jsonDecode(res.body)["user"]));
          await prefs.setString(
              'x-auth-token', jsonDecode(res.body)["user"]['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            LandingScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      print(e.toString());

      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${uri}tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('${uri}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
