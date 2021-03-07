import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/repository/activity_repo.dart';
import 'package:kilo/sharedpref.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:kilo/repository/user_data_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'navigate.dart';
import 'screens/home.dart';
import 'screens/intro.dart';
import 'screens/login.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/home': (context) => HomeScreen()
    },
  ));
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
  int cals;
  DateTime date = DateTime.now();
  String activityDate;
  
  @override
  void initState() {
    super.initState();
    timer = new Timer(const Duration(seconds: 3), () {
      afterSplash();
    });
  }

  saveUserSteps() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    steps = prefs.getInt('steps');
    activityDate = prefs.getString('activityDate');
    userDataRepo.saveUserSteps(activityDate, steps);
  }

  Future afterSplash() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginBloc.emailID = email = prefs.getString('email');
    open = prefs.getBool('open');
    activityRepo.lastSavedSteps = prefs.getInt('steps') != null ? prefs.getInt('steps') : 0;
    activityRepo.lastSavedDay = prefs.getString('stepsDate') != null ? DateTime.parse(prefs.getString('stepsDate')) : DateTime.now();
    if(email==null){
      await sharedPreference.resetSteps();
      await sharedPreference.resetCals();
      await sharedPreference.saveActivityDate();
      loginBloc.steps = prefs.getInt('steps');
      print("Steps ${loginBloc.steps}");
      if(open==null || open==false)
        navigate(context, Intro(), PageTransitionAnimation.fade, false);
      else{
        navigate(context, Login(), PageTransitionAnimation.fade, false);
      }
    }
    else{
      steps = prefs.getInt('steps');
      activityDate = prefs.getString('stepsDate');
      DateTime stpDate = DateTime.parse(activityDate);
      if(date.difference(stpDate).inDays>0){
        await sharedPreference.saveActivityDate();
        await sharedPreference.resetSteps();
        await sharedPreference.resetCals();
        userDataRepo.saveUserSteps(formatDate(date, [yyyy, '-', mm, '-', dd]), 0);
        userDataRepo.saveUserCals(formatDate(date, [yyyy, '-', mm, '-', dd]), 0);
      }
      else
        userDataRepo.saveUserSteps(activityDate, steps);
        userDataRepo.saveUserCals(activityDate, cals);
      loginBloc.steps = prefs.getInt('steps');
      await userDataRepo.getUserData(email);
      navigate(context, HomeScreen(), PageTransitionAnimation.fade, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done)
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
                    child: WavyAnimatedTextKit(
                      text: ['KILO'],
                      isRepeatingAnimation: false,
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  )
                ],
              ),
            )
          ),
        ),
      );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}