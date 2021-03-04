import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/activity_repo.dart';
import 'package:rxdart/rxdart.dart';

class ActivityBloc implements BaseBloc{
  
  //CONTROLLERS
  BehaviorSubject<List<int>> stepsController = BehaviorSubject();

  //SINKS
  Sink<List<int>> get stepsIn => stepsController.sink;

  //STREAMS
  Stream<List<int>> get stepsOut => stepsController.stream;

  getChartData(String type, Sink sink) async{
    sink.add(null);
    List data = List();
    data = await activityRepo.getChartData(type, sink);
    sink.add(data);
  }
  
  @override
  void dispose() {
    stepsController.close();
  }
}

final activityBloc = ActivityBloc();