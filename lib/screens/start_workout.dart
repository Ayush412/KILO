import 'package:flutter/material.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/screensize.dart';
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

  // ignore: non_constant_identifier_names
  navigate_function() {
    navigate(
      context,
      StartWorkout(
          workouts: widget.workouts, index: widget.index+1, difficulty: widget.difficulty),
      PageTransitionAnimation.slideRight,
      false
    );
  }

  @override
  Widget build(BuildContext context) {
    // '${widget.workouts[widget.index]['Image']}'
    // '${widget.workouts[widget.index][widget.difficulty]}'

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
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
                      navigate_function),
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
                          navigate(
                            context,
                            StartWorkout(
                                workouts: widget.workouts,
                                index: widget.index + 1,
                                difficulty: widget.difficulty),
                            PageTransitionAnimation.slideRight,
                            false
                          );
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
          ),
        )
      )
    );
  }
}
