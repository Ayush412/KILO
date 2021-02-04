import 'dart:async';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kilo/repository/user_data_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'navigate.dart';
import 'screens/home.dart';
import 'screens/intro.dart';
import 'screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Kilo()
    );
  }
}

class Kilo extends StatefulWidget {
  @override
  _KiloState createState() => _KiloState();
}

class _KiloState extends State<Kilo> {
  String email;
  bool open;
  Timer timer;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    timer = new Timer(const Duration(seconds: 2), () {
      afterSplash();
    });
  }

  Future afterSplash() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    open = prefs.getBool('open');
    if(email==null){
      if(open==null || open==false)
        navigate(context, Intro(), PageTransitionType.fade);
      else{
        navigate(context, Login(), PageTransitionType.fade);
      }
    }
    else{
      print(email);
      await userDataRepo.getUserData(email);
      navigate(context, HomeScreen(), PageTransitionType.fade);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("KILO.png", height: 100),
                Padding(
                  padding: const EdgeInsets.only(top:30),
                  child: Text("KILO", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold))
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}