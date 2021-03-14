import 'package:flutter/material.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/navigate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'home.dart';

class WorkoutStats extends StatefulWidget {
  final String difficulty;
  final List workouts;
  final int index;
  final double totCals;
  WorkoutStats({this.difficulty, this.workouts, this.index, this.totCals});

  @override
  _WorkoutStatsState createState() => _WorkoutStatsState();
}

class _WorkoutStatsState extends State<WorkoutStats> {
  
  double cals = 0;
  int mins = 0;
  int secs = 0;

  @override
  void initState() { 
    super.initState();
    for (int i=0; i<=widget.index; i++){
      cals+=widget.workouts[i]['${widget.difficulty} Calories'];
      secs+=widget.workouts[i][widget.difficulty];
    }
    mins = Duration(seconds: secs).inMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text('Workout Stats', style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),)
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding:  const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          Text('Exercises Completed', style: TextStyle(color: Colors.orange[400], fontSize: 20, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text('${widget.index+1}/${widget.workouts.length}',style: TextStyle(color: Colors.green, fontSize: 40)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding:  const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          Text('Duration', style: TextStyle(color: Colors.orange[400], fontSize: 20, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(secs <=60? '$secs sec' :'$mins mins',style: TextStyle(color: Colors.green, fontSize: 40)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding:  const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          Text('Calories Burnt', style: TextStyle(color: Colors.orange[400], fontSize: 20, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(cals.toString(),style: TextStyle(color: Colors.green, fontSize: 40)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding:  const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          Text('Total Calories Burnt', style: TextStyle(color: Colors.orange[400], fontSize: 20, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CircularPercentIndicator(
                              radius: 130,
                              backgroundWidth: 8,
                              lineWidth: 8,
                              percent: (widget.totCals>=loginBloc.calsGoal) ? 1 : widget.totCals/loginBloc.calsGoal,
                              animationDuration: 1500,
                              backgroundColor: Colors.grey[700],
                              progressColor: Colors.green,
                              center: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(widget.totCals.toString(), style: TextStyle(color: Colors.green, fontSize: 30)),
                                  Text('of ${loginBloc.calsGoal}', style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text('Well Done!', style: TextStyle(color: Colors.green, fontSize: 35, fontWeight: FontWeight.bold))
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: GestureDetector(
                      onTap: () => navigate(context, HomeScreen(), PageTransitionAnimation.fade, true),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width/1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white
                        ),
                        child: Center(
                          child: Text('Continue', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}