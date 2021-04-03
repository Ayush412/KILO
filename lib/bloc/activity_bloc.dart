import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/activity_repo.dart';
import 'package:rxdart/rxdart.dart';

class ActivityBloc implements BaseBloc{

  double totalCals = 0;

  //CONTROLLERS
  BehaviorSubject<int> stepsController = BehaviorSubject();
  BehaviorSubject<List> stepsChartController = BehaviorSubject();
  BehaviorSubject<List> calsChartController = BehaviorSubject();

  //SINKS
  Sink<int> get stepsIn => stepsController.sink;
  Sink<List> get stepsChartIn => stepsChartController.sink;
  Sink<List> get calsChartIn => calsChartController.sink;

  //STREAMS
  Stream<int> get stepsOut => stepsController.stream;
  Stream<List> get stepsChartOut => stepsChartController.stream;
  Stream<List> get calsChartOut => calsChartController.stream;

  getChartData(String type, Sink sink) async{
    List data = List();
    data = await activityRepo.getChartData(type, sink);
    sink.add(data);
  }
  
  @override
  void dispose() {
    stepsController.close();
    stepsChartController.close();
    calsChartController.close();
  }
}

final activityBloc = ActivityBloc();