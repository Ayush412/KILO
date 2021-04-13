import 'package:flutter/material.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/repository/activity_repo.dart';
import 'package:kilo/repository/user_data_repo.dart';
import 'package:kilo/screens/workout_stats.dart';
import 'package:kilo/sharedpref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:kilo/widgets/timer.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:date_format/date_format.dart';

class StartWorkout extends StatefulWidget {
  final int completed;
  final List workouts;
  final int index;
  final String difficulty;
  final String title;
  StartWorkout({this.completed, this.workouts, this.index, this.difficulty, this.title});
  @override
  _StartWorkoutState createState() => _StartWorkoutState();
}

class _StartWorkoutState extends State<StartWorkout> {
  CountDownController controller = CountDownController();
  bool play = false;
  IconData icon = Icons.pause;
  double totCals;
  int completed;

  navigateFunction() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double cals = prefs.getDouble('cals');
    totCals = cals + (widget.workouts[widget.index]['${widget.difficulty} Calories']).toDouble();
    sharedPreference.saveActivityDate();
    sharedPreference.saveCals(totCals);
    userDataRepo.saveUserCals(formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]), totCals);
    if(widget.index < widget.workouts.length-1)
      navigate(
        context,
        StartWorkout(
          completed: completed, workouts: widget.workouts, index: widget.index+1, difficulty: widget.difficulty, title: widget.title),
        PageTransitionAnimation.slideUp,
        false
      );
    else{
      if(completed == widget.workouts.length)
        await activityRepo.updateWorkoutCount('${widget.title} ${widget.difficulty}');
      navigate(
        context, 
        WorkoutStats(totCals: totCals, index: widget.index, workouts: widget.workouts, difficulty: widget.difficulty,), 
        PageTransitionAnimation.slideUp, 
        false
      );
    }
  }

  completedExercise(){
    completed += 1;
  }

  end() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double cals = prefs.getDouble('cals');
    totCals = cals + widget.workouts[widget.index]['${widget.difficulty} Calories'];
    sharedPreference.saveActivityDate();
    sharedPreference.saveCals(totCals);
    userDataRepo.saveUserCals(formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]), totCals);
    if(widget.index == widget.workouts.length-1 && completed == widget.workouts.length)
      await activityRepo.updateWorkoutCount('${widget.title} ${widget.difficulty}');
    navigate(
      context, 
      WorkoutStats(totCals: totCals, index: widget.index, workouts: widget.workouts, difficulty: widget.difficulty,), 
      PageTransitionAnimation.slideUp, 
      false
    );
  }

  endWorkout(BuildContext context){
    showDialogBox(context, '', 'End Workout?', end);
  }

  @override
  void initState() { 
    super.initState();
    completed = widget.completed;
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
                      height: MediaQuery.of(context).size.height/3,
                      width: MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(widget.workouts[widget.index]['Image']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text("${widget.index+1}/${widget.workouts.length}", style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: countdown(
                        context,
                        widget.workouts[widget.index][widget.difficulty],
                        controller,
                        navigateFunction,
                        completedExercise,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
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
                  child: RaisedButton(
                    color: Colors.orange[400].withOpacity(0.5),
                    shape: CircleBorder(),
                    onPressed: () => endWorkout(context),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}
