import 'package:kilo/bloc/badges_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
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
  int totalCals;
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
      sharedPreference.saveActivityDate();
      lastSavedSteps = event.steps;
      sharedPreference.saveSteps(lastSavedSteps);
    }
    loginBloc.steps = todaySteps = event.steps - lastSavedSteps;
    sharedPreference.saveSteps(todaySteps);
    sharedPreference.saveActivityDate();
    activityBloc.stepsIn.add(todaySteps);
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
    List<double> count = [];
    List<Data> chartData = [];
    Map<dynamic, dynamic> map = Map<dynamic, dynamic>();
    List<charts.Series<Data, String>> series = List<charts.Series<Data, String>>();
    String date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    var keys = [];
    List<String> labels = [];
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).get();
    map = ds.data()[type];
    if(ds.data()[type] == null)
      map = {date:0};
    keys = map.keys.toList()..sort();
    for (int i = 0; i < keys.length; i++) {
      count.add(map[keys[i]].toDouble());
      labels.add(
        (formatDate(DateTime.parse('${keys[i]} 00:00:00'), [dd, ' ', M, ' ', yy])).toString()
      );
      chartData.add(Data(labels[i], count[i]));
    }
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

  updateWorkoutCount(String workout) async{
    Map<String, dynamic> map = Map<String, dynamic>();
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).get();
    map = ds.data()['Workouts'];
    map[workout] += 1; 
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).update(
      {
        'Workouts': map
      }
    );
    await badgesBloc.getBadgeData();
  }
}
final activityRepo = ActivityRepo();

class Data{
  String date;
  double count;
  Data(this.date, this.count);
}