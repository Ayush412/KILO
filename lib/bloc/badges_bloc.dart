import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/badges_repo.dart';
import 'package:rxdart/rxdart.dart';

class BadgesBloc implements BaseBloc{

  //CONTROLLERS
  BehaviorSubject<List> firstBadgeController = BehaviorSubject();
  BehaviorSubject<List> stepsBadgeController = BehaviorSubject();
  BehaviorSubject<List> all3BadgeController = BehaviorSubject();
  BehaviorSubject<List> wlBadgeController = BehaviorSubject();
  BehaviorSubject<List> mbBadgeController = BehaviorSubject();
  BehaviorSubject<List> endBadgeController = BehaviorSubject();

  //SINKS
  Sink<List> get firstIn => firstBadgeController.sink;
  Sink<List> get stepsIn => stepsBadgeController.sink;
  Sink<List> get all3In => all3BadgeController.sink;
  Sink<List> get wlIn => wlBadgeController.sink;
  Sink<List> get mbIn => mbBadgeController.sink;
  Sink<List> get endIn => endBadgeController.sink;
  
  //STREAMS
  Stream<List> get firstOut => firstBadgeController.stream;
  Stream<List> get stepsOut => stepsBadgeController.stream;
  Stream<List> get all3Out => all3BadgeController.stream;
  Stream<List> get wlOut => wlBadgeController.stream;
  Stream<List> get mbOut => mbBadgeController.stream;
  Stream<List> get endOut => endBadgeController.stream;

  getBadgeData() async{
    await badgesRepo.getBadgeData();
  }

  @override
  void dispose() {
    firstBadgeController.close();
    stepsBadgeController.close();
    all3BadgeController.close();
    wlBadgeController.close();
    mbBadgeController.close();
    endBadgeController.close();
  }
}
final badgesBloc = BadgesBloc();