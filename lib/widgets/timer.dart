import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

countdown(BuildContext context, int duration, CountDownController controller, dynamic navigate, dynamic completedExercise){
  return CircularCountDownTimer(
    duration: duration,
    initialDuration: 0,
    controller: controller,
    width: MediaQuery.of(context).size.width / 2.5,
    height: MediaQuery.of(context).size.height / 2.5,
    ringColor: Colors.black,
    ringGradient: null,
    fillColor: Colors.orange[400],
    fillGradient: null,
    backgroundColor: Colors.black,
    backgroundGradient: null,
    strokeWidth: 20.0,
    strokeCap: StrokeCap.round,
    textStyle: TextStyle(
      fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold
    ),
    textFormat: CountdownTextFormat.S,
    isReverse: false,
    isReverseAnimation: false,
    isTimerTextShown: true,
    autoStart: false,
    onStart: () {
      print('Timer Started');
    },
    onComplete: () {
      completedExercise();
      navigate();
    },
  );
}