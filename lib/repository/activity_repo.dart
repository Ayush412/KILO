import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/sharedpref.dart';
import 'package:kilo/bloc/activity_bloc.dart';
import 'package:pedometer/pedometer.dart';
import 'package:health/health.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityRepo{

  int steps;
  Stream<StepCount> stepsStream;
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0,0,0);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23,59,59);
  HealthFactory health = HealthFactory();
  List<HealthDataType> types = [
    HealthDataType.STEPS,
    //HealthDataType.HEART_RATE,
    HealthDataType.HEIGHT,
    HealthDataType.WEIGHT,
    //HealthDataType.ACTIVE_ENERGY_BURNED,
  ];
  List<HealthDataPoint> _healthDataList = [];
  bool accessWasGranted;
  int fitnessBandSteps = 0;
  bool gFit;
  
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

  getFitData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool gFit = prefs.getBool('GFit');
    if(gFit==null || gFit == true){
      accessWasGranted = await health.requestAuthorization(types);
      if (accessWasGranted){
        sharedPreference.setGFitAccess(true);
        try {
          List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(startDate, endDate, types);
          _healthDataList.addAll(healthData);
        } catch (e) {print(e);}
        _healthDataList = HealthFactory.removeDuplicates(_healthDataList);
        _healthDataList.forEach((x) {
          print("$x: ${x.value}");
        });
        print("Steps: $fitnessBandSteps");
      }
      else{
        sharedPreference.setGFitAccess(false);
        print('No access');
      }
    }
  }
}

final activityRepo = ActivityRepo();