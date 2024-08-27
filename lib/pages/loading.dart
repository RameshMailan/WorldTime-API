import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = "loading";

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  Future<void> setupWorldTime() async {
    try {
      WorldTime instance = WorldTime(
          location: "Kolkata", flag: "India.png", url: "Asia/Kolkata");
      Future.delayed(const Duration(seconds: 10));
      await instance.getTime();
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          "/home",
          arguments: {
            'location': instance.location,
            'flag': instance.flag,
            'time': instance.time,
            'isDayTime': instance.isDayTime
          },
        );
      }
    } catch (e) {
      // Handle errors here, e.g., show an error message
      print("Error: $e");
      // You might want to show an error message or retry logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
