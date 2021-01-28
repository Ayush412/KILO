import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'bloc/login/login_bloc.dart';
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
      print('no email');
      if(open==null || open==false)
        navigate(context, Intro());
      else{
        navigate(context, Login());
      }
    }
    else{
      print(email);
      await loginBloc.getUserData(email);
      navigate(context, HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("scobo_logo.png", height: 100),
                Padding(
                  padding: const EdgeInsets.only(top:30),
                  child: Text("SCOBO", style: TextStyle(fontSize: 25, color: Colors.blue[600], fontWeight: FontWeight.bold))
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