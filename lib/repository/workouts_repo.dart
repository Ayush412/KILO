import 'package:kilo/bloc/workouts_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutsRepo{

  getWL() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('WLExercises').get();
    workoutsBloc.wlIn.add(qs.docs);
  }

  getMB() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('MBExercises').get();
    workoutsBloc.mbIn.add(qs.docs);
  }

  getEND() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('ENDExercises').get();
    workoutsBloc.endIn.add(qs.docs);
  }
}

final workoutsRepo = WorkoutsRepo();