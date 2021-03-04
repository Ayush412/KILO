import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/repository/user_data_repo.dart';
import 'package:kilo/sharedpref.dart';
import 'package:kilo/bloc/activity_bloc.dart';
import 'package:pedometer/pedometer.dart';
import 'package:health/health.dart';
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ActivityRepo{

  int todaySteps;
  int lastSavedSteps;
  DateTime lastSavedDay;
  Stream<StepCount> stepsStream;
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0,0,0);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23,59,59);
  HealthFactory health = HealthFactory();
  List<HealthDataType> types = [
    HealthDataType.STEPS,
    HealthDataType.HEIGHT,
    HealthDataType.WEIGHT,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
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
    if(event.steps < lastSavedSteps){
      lastSavedSteps = 0;
      sharedPreference.resetSteps();
    }
    if(DateTime.now().difference(lastSavedDay).inDays > 0){
      lastSavedDay = DateTime.now();
      sharedPreference.saveStepsDate();
      lastSavedSteps = event.steps;
      sharedPreference.saveSteps(lastSavedSteps);
    }
    loginBloc.steps = todaySteps = event.steps - lastSavedSteps;
    sharedPreference.saveSteps(todaySteps);
    sharedPreference.saveStepsDate();
    activityBloc.stepsIn.add([todaySteps, loginBloc.userMap['Steps Goal']]);
    print('steps repo pedo: $todaySteps');
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
      }
      else{
        sharedPreference.setGFitAccess(false);
        print('No access');
      }
    }
  }

  getChartData(String type, Sink sink) async{
    List<int> count;
    List<Data> chartData = List<Data>();
    Map<dynamic, dynamic> map = Map<dynamic, dynamic>();
    List<charts.Series<Data, String>> series = List<charts.Series<Data, String>>();
    String date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    var keys = [];
    List<String> labels = List<String>();
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).get();
    if(ds.data()['Steps'] == null){
      userDataRepo.saveUserSteps(date, 0);
    }
    if(ds.data()['Cals'] == null){
      userDataRepo.saveUserCals(date, 0);
    }
    keys = map.keys.toList()..sort();
    for (int i = 0; i < keys.length; i++) {
      count.add((map[keys[i]]));
      labels.add(
          (formatDate(DateTime.parse('${keys[i]} 00:00:00'), [dd, ' ', M, yy]))
              .toString());
      sink.add(Data(labels[i], count[i]));
      series = [
      charts.Series(
          id: type,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (Data count, _) => count.date,
          measureFn: (Data count, _) => count.count,
          data: chartData),
      ];
      return [labels, series];
    }
  }
}
final activityRepo = ActivityRepo();

class Data{
  String date;
  int count;
  Data(this.date, this.count);
}