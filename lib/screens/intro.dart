import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/screens/login.dart';
import 'package:kilo/sharedpref.dart';

import '../navigate.dart';
import '../sharedpref.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  List<Slide> slides = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides.add(
      new Slide(
        title: "TELL SCOBO WHAT TO DO",
        backgroundColor: Colors.white,
        description: "Give direction instructions to SCOBO and track its movements",
        styleTitle: TextStyle(color: Colors.blue[600], fontSize: 28, fontWeight: FontWeight.bold),
        styleDescription: TextStyle(color: Colors.blue[300], fontSize: 20),
        pathImage: "control.jpg",
        heightImage: 300
      )
    );
    slides.add(
      new Slide(
        title: "CHECK SCOBO'S STATUS",
        backgroundColor: Colors.white,
        description: "Get updates on SCOBO's connectivity and availability",
        styleTitle: TextStyle(color: Colors.blue[600], fontSize: 28, fontWeight: FontWeight.bold),
        styleDescription: TextStyle(color: Colors.blue[300], fontSize: 20),
        pathImage: "talk.jpg",
        heightImage: 300
      )
    );
    slides.add(
      new Slide(
        backgroundColor: Colors.white,
        description: "The SCOBO team thanks all healthcare workers for their service",
        styleTitle: TextStyle(color: Colors.blue[600], fontSize: 28, fontWeight: FontWeight.bold),
        styleDescription: TextStyle(color: Colors.blue[300], fontSize: 20),
        pathImage: "doctors.jpg",
        heightImage: 300
      )
    );
  }

  void onDonePress(){
    sharedPreference.openApp();
    navigate(context, Login());
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      backgroundColorAllSlides: Colors.white,
      isShowSkipBtn: false,
      isShowNextBtn: false,
      slides: slides,
      styleNameDoneBtn: TextStyle(color: Colors.blue[600], fontWeight: FontWeight.bold, fontSize: 20),
      styleNamePrevBtn: TextStyle(color: Colors.blue[300], fontWeight: FontWeight.bold, fontSize: 20),
      colorDot: Colors.blue[100],
      colorActiveDot: Colors.blue[600],
      onDonePress: onDonePress,
    );
  }
}