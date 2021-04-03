import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/badges_repo.dart';
import 'package:rxdart/rxdart.dart';

class BadgesBloc implements BaseBloc{

  //CONTROLLERS
  BehaviorSubject<int> firstBadgeController = BehaviorSubject();
  BehaviorSubject<int> stepsBadgeController = BehaviorSubject();
  BehaviorSubject<int> all3BadgeController = BehaviorSubject();
  BehaviorSubject<int> wlBadgeController = BehaviorSubject();
  BehaviorSubject<int> mbBadgeController = BehaviorSubject();
  BehaviorSubject<int> endBadgeController = BehaviorSubject();

  //SINKS
  Sink<int> get firstIn => firstBadgeController.sink;
  Sink<int> get stepsIn => stepsBadgeController.sink;
  Sink<int> get all3In => all3BadgeController.sink;
  Sink<int> get wlIn => wlBadgeController.sink;
  Sink<int> get mbIn => mbBadgeController.sink;
  Sink<int> get endIn => endBadgeController.sink;
  
  //STREAMS
  Stream<int> get firstOut => firstBadgeController.stream;
  Stream<int> get stepsOut => stepsBadgeController.stream;
  Stream<int> get all3Out => all3BadgeController.stream;
  Stream<int> get wlOut => wlBadgeController.stream;
  Stream<int> get mbOut => mbBadgeController.stream;
  Stream<int> get endOut => endBadgeController.stream;

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