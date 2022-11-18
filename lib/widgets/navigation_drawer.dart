import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dietplan_list_screen.dart';
import 'package:flutter_application_1/screens/food_list_screen.dart';
import 'package:flutter_application_1/screens/manage_screen.dart.dart';
import 'package:flutter_application_1/screens/landing_screen.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/screens/reminders_page.dart';
import 'package:flutter_application_1/screens/shopping_list_screen.dart';
import 'package:flutter_application_1/screens/stats_screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});
  final String name = 'Piumini Kaveesha';
  final String email = 'piumini95kaveesha@gmail.com';
  static const items = [
    'Home',
    'Diet Plans',
    'Manage',
    'Reminders',
    'Shopping List',
    'Explore',
    'Food List',
  ];
  static const List<Icon> icons = [
    Icon(
      Icons.home_outlined,
      color: Colors.black87,
      size: 30.0,
    ),
    Icon(
      Icons.calendar_month_outlined,
      color: Colors.black87,
      size: 30.0,
    ),
    Icon(
      Icons.rate_review_outlined,
      color: Colors.black87,
      size: 30.0,
    ),
    Icon(
      Icons.notifications_active_outlined,
      color: Colors.black87,
      size: 30.0,
    ),
    Icon(
      Icons.receipt_long_outlined,
      color: Colors.black87,
      size: 30.0,
    ),
    Icon(
      Icons.tips_and_updates_outlined,
      color: Colors.black87,
      size: 30.0,
    ),
    Icon(
      Icons.food_bank_outlined,
      color: Colors.black87,
      size: 30.0,
    ),
    Icon(
      Icons.manage_accounts_outlined,
      color: Colors.black87,
      size: 30.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ]),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Material(
        color: Colors.green[500],
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 52,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/premium-vector/african-american-woman-avatar-with-glasses-portrait-young-girl-vector-illustration-face_217290-363.jpg?w=2000"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Wrap(
        runSpacing: 10,
        children: [
          ListTile(
            title: Text(
              items[0],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: icons[0],
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LandingScreen()));
            },
          ),
          ListTile(
            title: Text(
              items[1],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 21,
              ),
            ),
            leading: icons[1],
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => DietPlanListScreen()));
            },
          ),
          ListTile(
            title: Text(
              items[2],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: icons[2],
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => EditDietPlanScreen()));
            },
          ),
          ListTile(
            title: Text(
              items[3],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: icons[3],
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ReminderScreen()));
            },
          ),
          ListTile(
            title: Text(
              items[4],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: icons[4],
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ShoppingListScreen()));
            },
          ),
          ListTile(
            title: Text(
              items[5],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: icons[5],
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => StatsScreen()));
            },
          ),
          ListTile(
            title: Text(
              items[6],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: icons[6],
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => FoodListScreen()));
            },
          ),
        ],
      ));
}
