import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/activity_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:date_format/date_format.dart';
import 'package:kilo/sharedpref.dart';

class UserDataRepo{
  
  Map<dynamic, dynamic> myMap = Map<dynamic, dynamic>();
  String date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  getUserData(String emailID, bool check) async{
    await sharedPreference.saveActivityDate();
    await FirebaseFirestore.instance.collection('users').doc(emailID).get().then((DocumentSnapshot snapshot){
      myMap = snapshot.data();
    });
    if(myMap==null){
      print('no data');
      loginBloc.userMap=null;
      loginBloc.liked=[];
    }
    else{
      myMap.putIfAbsent('emailID', () => emailID);
      loginBloc.userMap = myMap;
      loginBloc.calsGoal = myMap['Cals Goal'];
      if(myMap['Liked'] == null)
        loginBloc.liked = [];
      else
        loginBloc.liked = myMap['Liked'];
      if(check){
        if(myMap['Steps'] == null || myMap['Steps'][date]==null){
          sharedPreference.resetSteps();
          userDataRepo.saveUserSteps(date, 0);
        }
        else{
          int steps = myMap['Steps'][date];
          sharedPreference.saveSteps(steps);
        }
        if(myMap['Cals'] == null || myMap['Cals'][date]==null){
          sharedPreference.resetCals();
          userDataRepo.saveUserCals(date, 0);
        }
        else{
          double cals = myMap['Cals'][date];
          sharedPreference.saveCals(cals);
        }
      }
    }
  }

  saveUserData(Map map) async{
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).set({
      'Name': map['Name'],
      'Age': map['Age'],
      'Weight': map['Weight'],
      'Height': map['Height'],
      'BMI': map['BMI'],
      'BMI Status': map['BMI Status'],
      'Admin': 0,
      'Liked': [],
      'Steps Goal': 10000,
      'Cals Goal': 1000,
      'Balance': 0,
      'Steps': {formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]) : 0},
      'Cals': {formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]) : 0},
      'Workouts': {
        'Endurance Easy': 0, 
        'Endurance Hard': 0,
        'Endurance Medium': 0,
        'Muscle Build Easy': 0,
        'Muscle Build Hard': 0,
        'Muscle Build Medium': 0,
        'Weight Loss Easy': 0,
        'Weight Loss Hard': 0,
        'Weight Loss Medium': 0
      }
    });
    sharedPreference.saveData(loginBloc.emailID);
  }

  updateUserData(Map map) async{
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).update({
      'Age': map['Age'],
      'Weight': map['Weight'],
      'Height': map['Height'],
      'BMI': map['BMI'],
      'BMI Status': map['BMI Status'],
      'Steps Goal': map['Steps Goal']
    });
    await getUserData(loginBloc.emailID, false);
  }

  saveUserSteps(String date, int steps) async{
    Map<String, dynamic> map = Map<String, dynamic>();
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).get();
    map = ds.data()['Steps'];
    if(map == null)
      map = {date:steps};
    else
      map[date] = steps;
    map[date] = steps;
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).update({
      'Steps' : map
    });
  }

  saveUserCals(String date, double cals) async{
    activityBloc.totalCals = cals;
    Map<String, dynamic> map = Map<String, dynamic>();
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).get();
    map = ds.data()['Cals'];
    if(map == null)
      map = {date:cals};
    else
      map[date] = cals;
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).update({
      'Cals' : map
    });
  }

}
final userDataRepo = UserDataRepo();