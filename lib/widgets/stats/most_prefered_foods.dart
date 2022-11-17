import 'package:flutter/material.dart';
import '../../services/stats/stats_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MostOccuringFoods extends StatefulWidget {
  MostOccuringFoods({super.key});

  @override
  State<MostOccuringFoods> createState() => _MostOccuringFoodsState();
}

class _MostOccuringFoodsState extends State<MostOccuringFoods> {
  List data = [];
  String message = "";

  void getData() async {
    var response = await getMostOccuringFoods();
    if (response is String) {
      setState(() {
        message = response;
      });
    }
    if (response is List) {
      setState(() {
        data = response;
      });
    }
    print(response);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 25,
                spreadRadius: 10,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 15.0),
          child: Column(children: [
            const Text("Most Occuring Foods\nActive Diet Plan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                )),
            AspectRatio(
                aspectRatio: 16 / 9,
                child: data.isNotEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 10.0, 30.0, 0.0),
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                data[index][2]!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(data[index][1]!),
                                radius: 30,
                              ),
                            );
                          },
                        ),
                      )
                    : message == ""
                        ? const Center(
                            child: SpinKitSpinningLines (
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
                          ))
                          )
          ]),
        ),
      ),
    );
  }
}
