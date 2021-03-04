import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/workouts_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutsBloc implements BaseBloc{

  //CONTROLLERS
  BehaviorSubject<List<DocumentSnapshot>> wlController = BehaviorSubject();
  BehaviorSubject<List<DocumentSnapshot>> mbController = BehaviorSubject();
  BehaviorSubject<List<DocumentSnapshot>> endController = BehaviorSubject();

  //SINKS
  Sink<List<DocumentSnapshot>> get wlIn => wlController.sink;
  Sink<List<DocumentSnapshot>> get mbIn => mbController.sink;
  Sink<List<DocumentSnapshot>> get endIn => endController.sink;

  //STREAMS
  Stream<List<DocumentSnapshot>> get wlOut => wlController.stream;
  Stream<List<DocumentSnapshot>> get mbOut => mbController.stream;
  Stream<List<DocumentSnapshot>> get endOut => endController.stream;

  getWL() async{
    await workoutsRepo.getWL();
  }

  getMB() async{
    await workoutsRepo.getMB();
  }

  getEND() async{
    await workoutsRepo.getEND();
  }

  @override
  void dispose() {
    wlController.close();
    mbController.close();
    endController.close();
  }

}

final workoutsBloc = WorkoutsBloc();