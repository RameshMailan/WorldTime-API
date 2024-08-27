import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for a url
  String time =
      "https://www.worldtimeapi.org/api/timezone/Asia/Kolkata"; //the time in that location
  String flag; //url to an asset flag icon
  String url; //location url for api endpoint
  bool isDayTime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Response response = await get(
          Uri.parse("https://www.worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);
      //return data;

      //get properties from data
      String dateTime = data['datetime'];
      String offSet = data['utc_offset'].substring(1, 3);
      String offSet1 = data['utc_offset'].substring(4, 6);
      //create dateTime Object
      DateTime now = DateTime.parse(dateTime);
      now = now
          .add(Duration(hours: int.parse(offSet), minutes: int.parse(offSet1)));

      //Set the time property
      isDayTime = ((now.hour >= 6 && now.hour <= 18 ? true : false) as bool?)!;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("Caught Error: e");
      time = "Could not got time data";
    }
  }
}
