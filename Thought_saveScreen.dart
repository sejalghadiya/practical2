import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThoughtScreen extends StatefulWidget {
  final List<String> thoughtList;

  ThoughtScreen({Key? key, required this.thoughtList}) : super(key: key);

  @override
  State<ThoughtScreen> createState() => _ThoughtScreenState();
}

class _ThoughtScreenState extends State<ThoughtScreen> {
  DateTime currentTime = DateTime.now();
  TextEditingController thoughtController = TextEditingController();
  List<String> thoughtList = [];

  @override
  void saveThought() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String thought = thoughtController.text;
    String dateTime = currentTime.toString();

    await prefs.setString('thought\n', thought);
    await prefs.setString('dateTime', dateTime);

    String thoughtWithDateTime = '$thought\n$dateTime';
    thoughtList.add('$thought\n$dateTime');

    await prefs.setStringList('thoughtList', thoughtList);

    thoughtController.clear();
  }
  @override
  void initState() {
    super.initState();
    thoughtList = widget.thoughtList;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(right: 15,left: 15),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.grey.shade300)
              ),
              child: Text(
                'Saved Thoughts:',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(height: 1.5,color: Colors.black),
            Expanded(
              child: ListView.builder(
                itemCount: thoughtList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(thoughtList[index]),
                      ),
                      Container(height: 2,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
