import 'package:flutter/material.dart';
import 'package:kilo/screensize.dart';
import 'package:kilo/widgets/workout_list.dart';

class WorkoutScreen extends StatefulWidget {
  final List workouts;
  final int duration;
  final String image;
  final String difficulty;
  final String title;
  WorkoutScreen({this.workouts, this.duration, this.image, this.difficulty, this.title});
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: screenSize(250, context),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.image),
                        fit: BoxFit.fill
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              '${widget.title}: ${widget.difficulty}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 55.0),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Time',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.orange),
                                ),
                                Text(
                                  '${widget.duration} mins',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.orange[600],
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 45.0),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Intensity',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.orange,
                                  ),
                                ),
                                Text(
                                  widget.difficulty,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.orange[600],
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: MediaQuery.of(context).size.height/2.9,
                      child: workoutList(widget.workouts, widget.difficulty)
                    )
                  )
                ],
              )
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: RaisedButton(
                  color: Colors.orange[400].withOpacity(0.5),
                  shape: CircleBorder(),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(Icons.arrow_back, color: Colors.white,),
                ),
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.orange[400],
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(100, 140, 255, 0.5),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ]),
                  child: Text(
                    'Start',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}