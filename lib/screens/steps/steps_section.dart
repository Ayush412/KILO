import 'package:flutter/material.dart';
import 'package:kilo/bloc/activity_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/repository/radical_progress.dart';

class StepsSection extends StatelessWidget {
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
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Steps',
                    style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    child: Image.asset(
                      'assets/shoe.png',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: activityBloc.stepsOut,
            builder: (context, steps) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 130.0,
                  height: 130.0,
                  child: RadialProgressbar(
                    trackColor: Colors.white.withOpacity(0.6),
                    progressPercent: ( steps.data>=loginBloc.userMap['Steps Goal'] ) ? 1 :  steps.data/loginBloc.userMap['Steps Goal'] ?? 0,
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
                                steps.data.toString(),
                                style: TextStyle(
                                  fontSize: 36.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'of ${loginBloc.userMap['Steps Goal']}',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}