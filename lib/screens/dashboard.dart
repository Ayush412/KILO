//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:kilo/bloc/activity_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/repository/activity_repo.dart';
import 'package:kilo/screens/steps/steps_section.dart';
import 'package:kilo/widgets/graph.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:kilo/repository/header_info.dart';
import 'package:kilo/screens/sections.dart';
import 'package:kilo/screens/calories/calories_section.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {

    var _widthFull = MediaQuery.of(context).size.width;

    @override
    void initState() {
      super.initState();
      activityRepo.initialiseSteps();
      activityBloc.stepsIn.add(loginBloc.steps);
      activityBloc.getChartData('Steps', activityBloc.stepsChartIn);
      activityBloc.getChartData('Cals', activityBloc.calsChartIn);
    }
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
                          child: InkWell(
                            onTap: () {},
                            child: CaloriesSection(),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Sections(
                            widthFull: _widthFull,
                            child: StepsSection(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: lineChart(context, activityBloc.stepsChartOut, 'Steps'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: lineChart(context, activityBloc.calsChartOut, 'Cals'),
                    )
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
