//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:kilo/bloc/activity_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/screens/calories/calories.dart';
import 'package:kilo/widgets/steps_indicator.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:kilo/repository/activity_repo.dart';
import 'package:kilo/repository/header_info.dart';
import 'package:kilo/screens/heartrate/heart_rate.dart';
import 'package:kilo/screens/heartrate/heart_rate_section.dart';
import 'package:kilo/screens/sleep/sleep_section.dart';
import 'package:kilo/screens/sections.dart';
import 'package:kilo/screens/calories/calories_section.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var _widthFull = MediaQuery.of(context).size.width;
    //void initState() {
    //super.initState();
    //print([loginBloc.steps, loginBloc.userMap['Steps Goal']]);
    //activityBloc.stepsIn.add([loginBloc.steps, loginBloc.userMap['Steps Goal']]);
    //activityRepo.initialiseSteps();
    //}
    return Scaffold(
      appBar: AppBar(
        title: underlineText('Dashboard', 24, Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    HeaderInfo(
                      isMain: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Sections(
                          widthFull: _widthFull,
                          child: SleepSection(),
                        ),
                        //Sections(
                        //widthFull: _widthFull,
                        //child: stepsIndicator(context),
                        //),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Sections(
                          widthFull: _widthFull,
                          child: InkWell(
                            onTap: () {
                              navigate(context, CaloriesPage(),
                                  PageTransitionAnimation.slideRight, false);
                            },
                            child: CaloriesSection(),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            navigate(context, HeartRatePage(),
                                PageTransitionAnimation.slideRight, false);
                          },
                          child: Sections(
                            widthFull: _widthFull,
                            child: HeartRate(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          )
        ]
      )
    );
  }
}
