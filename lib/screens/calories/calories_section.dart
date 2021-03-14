import 'package:flutter/material.dart';
import 'package:kilo/bloc/activity_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/repository/radical_progress.dart';

class CaloriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          colors: [
            Color(0xFFD79609),
            Color(0xFFC74318),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Calories',
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    child: Image.asset(
                      'assets/fire.png',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: 130.0,
              height: 130.0,
              child: RadialProgressbar(
                trackColor: Colors.white.withOpacity(0.6),
                progressPercent: ( activityBloc.totalCals>=loginBloc.calsGoal) ? 1 :  activityBloc.totalCals/loginBloc.calsGoal,
                progressColor: Colors.white,
                innerPadding: const EdgeInsets.all(6.0),
                child: ClipOval(
                  clipper: CircleClipper(),
                  child: Container(
                    width: 120.0,
                    height: 120.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            activityBloc.totalCals.toString(),
                            style: TextStyle(
                              fontSize: 36.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'of ${loginBloc.calsGoal}',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          Text('kcal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}