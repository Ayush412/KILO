import 'package:flutter/material.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/screens/workout_stats.dart';
import 'package:kilo/screensize.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:kilo/widgets/timer.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class StartWorkout extends StatefulWidget {
  final List workouts;
  final int index;
  final String difficulty;
  StartWorkout({this.workouts, this.index, this.difficulty});

  @override
  _StartWorkoutState createState() => _StartWorkoutState();
}

class _StartWorkoutState extends State<StartWorkout> {
  CountDownController controller = CountDownController();
  bool play = true;
  IconData icon = Icons.pause;

  navigateFunction() {
    if(widget.index == widget.workouts.length-1)
      navigate(
        context,
        StartWorkout(
            workouts: widget.workouts, index: widget.index+1, difficulty: widget.difficulty),
        PageTransitionAnimation.slideUp,
        false
      );
    else
      navigate(
        context, 
        WorkoutStats(workouts: widget.workouts, difficulty: widget.difficulty,), 
        PageTransitionAnimation.slideUp, 
        false
      );
  }

  endWorkout(BuildContext context){
    showDialogBox(context, '', 'End Workout?', Navigator.pushNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => endWorkout(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.workouts[widget.index]['Name'], 
                      style: TextStyle(color: Colors.white, fontSize: 24) ),
                    ),

                    Container(
                      height: screenSize(250, context),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.workouts[widget.index]['Image']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: countdown(
                        context,
                        widget.workouts[widget.index][widget.difficulty],
                        controller,
                        navigateFunction,
                        widget.workouts[widget.index]['${widget.difficulty} Calories']
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.white,
                            icon: Icon(Icons.arrow_back),
                            iconSize: 40,
                          ),
                      
                          IconButton(
                            onPressed: () {
                              if (play) {
                                controller.pause();
                                setState(() {
                                  play = false;
                                });
                              } else {
                                controller.resume();
                                setState(() {
                                  play = true;
                                });
                              }
                            },
                            color: Colors.white,
                            icon: Icon(play ? Icons.pause : Icons.play_arrow),
                            iconSize: 40,
                          ),
                          
                          IconButton(
                            onPressed: () {
                              navigateFunction();
                            },
                            color: Colors.white,
                            icon: Icon(Icons.arrow_forward),
                            iconSize: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: RaisedButton(
                      color: Colors.orange[400].withOpacity(0.5),
                      shape: CircleBorder(),
                      onPressed: () => endWorkout(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  )
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}
