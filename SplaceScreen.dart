import 'package:exam/ClockScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5),(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ClockScreen()));
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP5F2Q6v5YpzDgkLaLi_LiPkMOyyAQV5wNin6UCc4KzLHNXDwPryTdcuVA29xMY7so-aU&usqp=CAU',fit: BoxFit.fill),
      ),
    );
  }
}
