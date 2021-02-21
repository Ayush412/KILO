import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kilo/bloc/workouts_bloc.dart';
import 'package:kilo/widgets/recommended_card.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:kilo/widgets/workout_cards.dart';


class Record extends StatefulWidget {
  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {

  workoutHeading(String title, double top){
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: top),
        child: Text(title,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.grey[800]),
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    workoutsBloc.wlIn.add(null);
    workoutsBloc.mbIn.add(null);
    workoutsBloc.endIn.add(null);
    workoutsBloc.getWL();
    workoutsBloc.getMB();
    workoutsBloc.getEND();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: underlineText('Workouts', 24, Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  workoutHeading('Recommended For You', 10),
                  recommendedCard(context, 8, 'image001.jpg'),
                  workoutHeading('Weight Loss', 40),
                  workout(context, workoutsBloc.wlOut, 'Weight Loss', ['wl1.jpg','wl2.jpg','wl3.jpg']),
                  workoutHeading('Muscle Build', 40),
                  workout(context, workoutsBloc.mbOut, 'Muscle Build', ['mb1.jpg','mb2.jpg','mb3.jpg']),
                  workoutHeading('Endurance', 40),
                  workout(context, workoutsBloc.endOut, 'Endurance', ['end1.jpg','end2.jpg','end3.jpg'])
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
