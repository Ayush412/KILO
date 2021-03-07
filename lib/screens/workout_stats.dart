import 'package:flutter/material.dart';

class WorkoutStats extends StatefulWidget {
  final String difficulty;
  final List workouts;
  WorkoutStats({this.difficulty, this.workouts});

  @override
  _WorkoutStatsState createState() => _WorkoutStatsState();
}

class _WorkoutStatsState extends State<WorkoutStats> {
  
  int cals=0;

  @override
  void initState() { 
    super.initState();
    for (int i=0; i<widget.workouts.length; i++){
      cals+=widget.workouts[i]['${widget.difficulty} Calories'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              
            ),
          ),
        ),
      ),
    );
  }
}