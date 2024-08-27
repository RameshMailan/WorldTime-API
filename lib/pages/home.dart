import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments =
          (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?);
      if (arguments != null) {
        setState(() {
          data = arguments;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDayTime = data["isDayTime"] ?? false;

    //set background
    String bgImage = data["isDayTime"] ? "day.png" : "night.png";

    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/$bgImage"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      data = {
                        "time": result["time"],
                        "location": result["location"],
                        "isDayTime": result["isDayTime"],
                        "flag": result["flag"]
                      };
                    });
                  }
                },
                icon: const Icon(Icons.edit_location, color: Colors.white),
                label: const Text(
                  "Edit Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data["location"] ?? "Unknown Location",
                    style: const TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                data["time"] ?? "Unknown Time",
                style: const TextStyle(
                  fontSize: 66,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
