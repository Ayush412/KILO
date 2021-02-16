import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:kilo/bloc/activity_bloc.dart';

stepsIndicator(BuildContext context){
  return StreamBuilder(
    stream: activityBloc.stepsOut,
    builder: (context, steps){
      return CircularPercentIndicator(
        radius: 160,
        backgroundWidth: 8,
        lineWidth: 8,
        percent: (steps.data[0]>=steps.data[1]) ? 1 : steps.data[0]/steps.data[1],
        animationDuration: 1500,
        backgroundColor: Colors.grey,
        progressColor: Colors.orange[400],
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('shoe.png', height: 90,),
            Text(steps.data[0].toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
          ],
        ),
      );
    },
  );
}