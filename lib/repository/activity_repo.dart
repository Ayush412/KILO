import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/sharedpref.dart';
import 'package:kilo/bloc/activity_bloc.dart';
import 'package:pedometer/pedometer.dart';

class ActivityRepo{

  int steps;
  Stream<StepCount> stepsStream;
  
  initialiseSteps(){
    stepsStream = Pedometer.stepCountStream;
    stepsStream.listen(onStepCount).onError(onStepCountError);
  }
  onStepCount(StepCount event){
    steps = event.steps;
    activityBloc.stepsIn.add([steps, loginBloc.userMap['Steps Goal']]);
    sharedPreference.saveSteps(steps);
  }
  onStepCountError(error){
    print('onStepCountError: $error');
  }

}

final activityRepo = ActivityRepo();