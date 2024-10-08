import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  void getData() async {}

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<WorldTime> locations = [
    WorldTime(url: "Asia/Kolkata", location: "Kolkata", flag: "india.png"),
    WorldTime(url: "Africa/Cairo", location: "cairo", flag: "egypt.png"),
    WorldTime(url: "Europe/Berlin", location: "Athens", flag: "greece.png"),
    WorldTime(url: "Asia/Seoul", location: "Seoul", flag: "south_Korea.png"),
    WorldTime(url: "America/New_York", location: "New York", flag: "usa.png"),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    //navigate to home screen
    Navigator.pop(context, {
      "location": instance.location,
      "flag": instance.flag,
      "time": instance.time,
      "isDayTime": instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: const Text("Choose a Location"),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      updateTime(index);
                    },
                    title: Text(locations[index].location),
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/${locations[index].flag}"),
                    ),
                  ),
                ),
              );
            }));
  }
}
