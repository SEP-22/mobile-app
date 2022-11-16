import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/navigation_drawer.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../services/reminders/notification_service.dart';
import '../services/reminders/Reminder.dart';
import '../services/reminders/reminder_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  String message = "";
  String id = "";
  bool loading = true;
  bool breakfast = false;
  TimeOfDay breakfastTime = const TimeOfDay(hour: 00, minute: 00);
  bool lunch = false;
  TimeOfDay lunchTime = const TimeOfDay(hour: 00, minute: 00);
  bool dinner = false;
  TimeOfDay dinnerTime = const TimeOfDay(hour: 00, minute: 00);

  void getData() async {
    print("hello");
    var response = await getReminder();
    if (response is String) {
      setState(() {
        message = response;
      });
    }
    if (response is Reminder) {
      setState(() {
        id = response.id;
        breakfast = response.breakfastOn;
        lunch = response.lunchOn;
        dinner = response.dinnerOn;
        breakfastTime = response.breakfastTime;
        lunchTime = response.lunchTime;
        dinnerTime = response.dinnerTime;
        message = "";
      });
    }
    setState(() {
      loading = false;
    });
    print(response);
  }

  late final NotificationService notificationService;
  @override
  void initState() {
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();
    getData();
    super.initState();
  }

  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MySecondScreen(payload: payload)));
      });

  void setBreakfast() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: breakfastTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xfff178b6), // <-- SEE HERE
              onPrimary: Color(0xffbc4786), // <-- SEE HERE
              onSurface: Color(0xffbc4786), // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    );

    // if 'CANCEL' => null
    if (newTime == null) {
      return;
    }

    String res = await updateBreakfast(id, newTime, true);

    if (res == 'success') {
      setState(() {
        breakfastTime = newTime;
        breakfast = true;
      });
    } else {
      showSnackBar();
      return;
    }

    await notificationService.showDailyNotification(
        id: 0,
        title: "Breakfast Time",
        body: "It is time to have your BREAKFAST !!!",
        payload: "You are here to take your breakfast! Huurray!",
        schedule: tz.TZDateTime.local(
            2020, 6, 1, newTime.hour, newTime.minute, 0, 0, 0));
  }

  void setLunch() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: lunchTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xfff178b6), // <-- SEE HERE
              onPrimary: Color(0xffbc4786), // <-- SEE HERE
              onSurface: Color(0xffbc4786), // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    );

    // if 'CANCEL' => null
    if (newTime == null) {
      return;
    }

    String res = await updateLunch(id, newTime, true);

    if (res == 'success') {
      setState(() {
        breakfastTime = newTime;
        breakfast = true;
      });
    } else {
      showSnackBar();
      return;
    }

    setState(() {
      lunchTime = newTime;
      lunch = true;
    });

    await notificationService.showDailyNotification(
        id: 1,
        title: "Lunch Time",
        body: "It is time to have your LUNCH !!!",
        payload: "You are here to take your lunch! Huurray!",
        schedule: tz.TZDateTime.local(
            2020, 6, 1, newTime.hour, newTime.minute, 0, 0, 0));
  }

  void setDinner() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: dinnerTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xfff178b6), // <-- SEE HERE
              onPrimary: Color(0xffbc4786), // <-- SEE HERE
              onSurface: Color(0xffbc4786), // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    );

    // if 'CANCEL' => null
    if (newTime == null) {
      return;
    }

    String res = await updateDinner(id, newTime, true);

    if (res == 'success') {
      setState(() {
        breakfastTime = newTime;
        breakfast = true;
      });
    } else {
      showSnackBar();
      return;
    }

    setState(() {
      dinnerTime = newTime;
      dinner = true;
    });

    await notificationService.showDailyNotification(
        id: 2,
        title: "Dinner Time",
        body: "It is time to have your DINNER !!!",
        payload: "You are here to take your dinner! Huurray!",
        schedule: tz.TZDateTime.local(
            2020, 6, 1, newTime.hour, newTime.minute, 0, 0, 0));
  }

  void cancelBreakfast() async {
    String res = await cancelDBBreakfast(id);

    if (res == 'success') {
      await notificationService.cancelNotifications(0);
      setState(() {
        breakfast = false;
      });
    } else {
      showSnackBar();
      return;
    }
  }

  void cancelLunch() async {
    String res = await cancelDBLunch(id);

    if (res == 'success') {
      await notificationService.cancelNotifications(1);
      setState(() {
        lunch = false;
      });
    } else {
      showSnackBar();
      return;
    }
  }

  void cancelDinner() async {
    String res = await cancelDBDinner(id);

    if (res == 'success') {
      await notificationService.cancelNotifications(2);
      setState(() {
        dinner = false;
      });
    } else {
      showSnackBar();
      return;
    }
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: const [
          Icon(
            Icons.error,
            color: Colors.pink,
            size: 24.0,
          ),
          Text('Couldn\'t update. Something went Wrong!')
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bhours = breakfastTime.hour.toString().padLeft(2, '0');
    final bminutes = breakfastTime.minute.toString().padLeft(2, '0');
    final lhours = lunchTime.hour.toString().padLeft(2, '0');
    final lminutes = lunchTime.minute.toString().padLeft(2, '0');
    final dhours = dinnerTime.hour.toString().padLeft(2, '0');
    final dminutes = dinnerTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders"),
        backgroundColor: Colors.green[500],
      ),
      drawer: const NavDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lightGreen[100],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
          child: !loading && message == ""
              ? Column(
                  children: [
                    const Text("NEVER miss a MEAL",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFF263238),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          wordSpacing: 4,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("set reminders for each meal",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    AspectRatio(
                      aspectRatio: 16 / 6,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Breakfast",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Color(0xFF1b5e20),
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text("$bhours:$bminutes",
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Color(0xFF7cb342),
                                    fontWeight: FontWeight.bold,
                                  )),
                              Switch(
                                // This bool value toggles the switch.
                                value: breakfast,
                                activeColor: const Color(0xfff178b6),
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  if (value) {
                                    setBreakfast();
                                  } else {
                                    cancelBreakfast();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AspectRatio(
                      aspectRatio: 16 / 6,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Lunch",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Color(0xFF1b5e20),
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text("$lhours:$lminutes",
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Color(0xFF7cb342),
                                    fontWeight: FontWeight.bold,
                                  )),
                              Switch(
                                // This bool value toggles the switch.
                                value: lunch,
                                activeColor: const Color(0xfff178b6),
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  if (value) {
                                    setLunch();
                                  } else {
                                    cancelLunch();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AspectRatio(
                      aspectRatio: 16 / 6,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Dinner",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Color(0xFF1b5e20),
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text("$dhours:$dminutes",
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Color(0xFF7cb342),
                                    fontWeight: FontWeight.bold,
                                  )),
                              Switch(
                                // This bool value toggles the switch.
                                value: dinner,
                                activeColor: const Color(0xfff178b6),
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  if (value) {
                                    setDinner();
                                  } else {
                                    cancelDinner();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : message == ""
                  ? const Center(
                      child: SpinKitSpinningLines(
                        color: Colors.blueGrey,
                        size: 50.0,
                      ),
                    )
                  : Center(
                      child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2,
                        wordSpacing: 10,
                      ),
                    )),
        ),
      ),
    );
  }
}

class MySecondScreen extends StatelessWidget {
  final String payload;
  const MySecondScreen({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Time"),
        backgroundColor: Colors.green[500],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: payload.contains('breakfast')
                  ? Image.asset(
                      "assets/breakfast.png",
                    )
                  : payload.contains('lunch')
                      ? Image.asset(
                          "assets/lunch.png",
                        )
                      : Image.asset(
                          "assets/dinner.png",
                        ),
            ),
            Text(payload)
          ],
        ),
      ),
    );
  }
}
