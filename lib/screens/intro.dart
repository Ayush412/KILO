import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:page_transition/page_transition.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/screens/login.dart';
import 'package:kilo/sharedpref.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  List<Slide> slides = List();

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "ACTIVITY TRACKING",
        description: "KILO will track and log your workouts as well as calories burnt",
        backgroundColor: Colors.black,
        styleTitle: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        styleDescription: TextStyle(color: Colors.orange[300], fontSize: 20),
        pathImage: "activity.png",
        heightImage: 160,
        backgroundImage: "activity_intro.jpg"
      )
    );
    slides.add(
      new Slide(
        title: "PERSONAL TRAINER",
        description: "Get personalized workout routines based on your BMI and goals",
        backgroundColor: Colors.black,
        styleTitle: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        styleDescription: TextStyle(color: Colors.orange[300], fontSize: 20),
        pathImage: "trainer.png",
        heightImage: 160,
        backgroundImage: "trainer_intro.jpg"
      )
    );
    slides.add(
      new Slide(
        title: "E-WALLET",
        description: "Pay for membership fees and other in-store products",
        backgroundColor: Colors.black,
        styleTitle: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        styleDescription: TextStyle(color: Colors.orange[300], fontSize: 20),
        pathImage: "wallet.png",
        heightImage: 160,
        backgroundImage: "wallet_intro.jpg"
      )
    );
    slides.add(
      new Slide(
        title: "CONTACT TRACING",
        description: "Get notified of unwell members in your vicinity at the gym",
        backgroundColor: Colors.black,
        styleTitle: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        styleDescription: TextStyle(color: Colors.orange[300], fontSize: 20),
        pathImage: "tracing.png",
        heightImage: 160,
        backgroundImage: "tracing_intro.jpg",
        backgroundOpacity: 0.6
      )
    );
  }

  void onDonePress(){
    //sharedPreference.openApp();
    navigate(context, Login(), PageTransitionType.fade);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: IntroSlider(
        backgroundColorAllSlides: Colors.black,
        isShowSkipBtn: false,
        isShowNextBtn: false,
        slides: slides,
        styleNameDoneBtn: TextStyle(color: Colors.orange[400], fontWeight: FontWeight.bold, fontSize: 20),
        styleNamePrevBtn: TextStyle(color: Colors.orange[400], fontWeight: FontWeight.bold, fontSize: 20),
        colorDot: Colors.white,
        colorActiveDot: Colors.orange[400],
        onDonePress: onDonePress,
      ),
    );
  }
}