import 'dart:async';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/sharedpref.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kilo/repository/user_data_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
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
  int steps;
  DateTime date = DateTime.now();
  String stepsDate;
  

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    timer = new Timer(const Duration(seconds: 3), () {
      afterSplash();
    });
  }

  saveUserSteps() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    steps = prefs.getInt('steps');
    stepsDate = prefs.getString('stepsDate');
    userDataRepo.saveUserSteps(stepsDate, steps);
  }

  Future afterSplash() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginBloc.emailID = email = prefs.getString('email');
    open = prefs.getBool('open');
    userDataRepo.saveUserSteps(stepsDate, steps);
    if(email==null){
      await sharedPreference.saveStepsDate();
      await sharedPreference.saveSteps(0);
      if(open==null || open==false)
        navigate(context, Intro(), PageTransitionAnimation.fade, false);
      else{
        navigate(context, Login(), PageTransitionAnimation.fade, false);
      }
    }
    else{
      steps = prefs.getInt('steps');
      loginBloc.steps = prefs.getInt('steps');
      stepsDate = prefs.getString('stepsDate');
      DateTime stpDate = DateTime.parse(stepsDate);
      if(date.difference(stpDate).inDays>0){
        sharedPreference.resetSteps();
        sharedPreference.saveStepsDate();
        userDataRepo.saveUserSteps(formatDate(date, [yyyy, '-', mm, '-', dd]), 0);
      }
      userDataRepo.saveUserSteps(stepsDate, steps);
      await userDataRepo.getUserData(email);
      navigate(context, HomeScreen(), PageTransitionAnimation.fade, true);
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