import 'package:kilo/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class ActivityBloc implements BaseBloc{
  
  //CONTROLLERS
  BehaviorSubject<List<int>> stepsController = BehaviorSubject();

  //SINKS
  Sink<List<int>> get stepsIn => stepsController.sink;

  //STREAMS
  Stream<List<int>> get stepsOut => stepsController.stream;

  @override
  void dispose() {
    stepsController.close();
  }
}

final activityBloc = ActivityBloc();