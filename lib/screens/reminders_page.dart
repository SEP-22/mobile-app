import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../services/reminders/notification_service.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool breakfast = false;
  TimeOfDay breakfastTime = const TimeOfDay(hour: 08, minute: 00);
  bool lunch = false;
  TimeOfDay lunchTime = const TimeOfDay(hour: 01, minute: 00);
  bool dinner = false;
  TimeOfDay dinnerTime = const TimeOfDay(hour: 20, minute: 30);

  late final NotificationService notificationService;
  @override
  void initState() {
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();
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

    setState(() {
      breakfastTime = newTime;
      breakfast = true;
    });

    await notificationService.showDailyNotification(
        id: 0,
        title: "Breakfast Time",
        body: "It is time to have your BREAKFAST !!!",
        payload: "You just took breakfast! Huurray!",
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

    setState(() {
      lunchTime = newTime;
      lunch = true;
    });

    await notificationService.showDailyNotification(
        id: 1,
        title: "Lunch Time",
        body: "It is time to have your LUNCH !!!",
        payload: "You just took lunch! Huurray!",
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

    setState(() {
      dinnerTime = newTime;
      dinner = true;
    });

    await notificationService.showDailyNotification(
        id: 2,
        title: "Dinner Time",
        body: "It is time to have your DINNER !!!",
        payload: "You just took dinner! Huurray!",
        schedule: tz.TZDateTime.local(
            2020, 6, 1, newTime.hour, newTime.minute, 0, 0, 0));
  }

  void cancelBreakfast() async {
    await notificationService.cancelNotifications(0);
    setState(() {
      breakfast = false;
    });
  }

  void cancelLunch() async {
    await notificationService.cancelNotifications(1);
    setState(() {
      lunch = false;
    });
  }

  void cancelDinner() async {
    await notificationService.cancelNotifications(2);
    setState(() {
      dinner = false;
    });
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lightGreen[100],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
          child: Column(children: [
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
          ]),
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
        title: const Text("JustWater"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Image.asset(
                "assets/images/justwater.png",
              ),
            ),
            Text(payload)
          ],
        ),
      ),
    );
  }
}
