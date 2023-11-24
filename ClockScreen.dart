import 'package:exam/Thought_saveScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  DateTime currentTime = DateTime.now();
  TextEditingController thoughtController = TextEditingController();
  List<String> thoughtList = [];

  @override
  void updateTime(){
    Future.delayed(Duration(seconds: 1),(){
      if(mounted){
        currentTime = DateTime.now();
        updateTime();
      }
    });
  }

  void loadThoughts() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? saveThoughts = prefs.getStringList('thoughtList');
    if (saveThoughts != null){
      thoughtList = saveThoughts;
    }
  }
  void saveThought() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String thought = thoughtController.text;
    String dateTime = currentTime.toString();

    await prefs.setString('thought', thought);
    await prefs.setString('\ndateTime', dateTime);

    thoughtList.add('$thought - $dateTime');

    await prefs.setStringList('thoughtList', thoughtList);

    thoughtController.clear();
  }

  @override
  void initState() {
    super.initState();
    updateTime();
    loadThoughts();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80,),
          Container(
            height: 150,
            width: 150,
            child: AnalogClock(
              dateTime: DateTime.now(),
              isKeepTime: false,
              child: const Align(
                alignment: FractionalOffset(0.5, 0.75),
              ),
            ),
          ),
          SizedBox(height: 50,),
          Container(margin: EdgeInsets.all(20),
            child: TextField(
              controller: thoughtController,
              decoration: InputDecoration(
                hintText: 'Enter your thought...',
              ),),
          ),
          SizedBox(height: 40),
          Container(
            height: 40,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black38,
            ),
            child: TextButton(
              onPressed: (){
                saveThought();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ThoughtScreen(thoughtList: thoughtList)));
              },
              child: Text('Mark My Thought',style: TextStyle(color: Colors.black,fontSize: 17),),
            ),
          )
        ],
      ),
    );
  }
}
