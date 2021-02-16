import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:date_format/date_format.dart';
import 'package:kilo/sharedpref.dart';

class UserDataRepo{
  
  Map<dynamic, dynamic> myMap = Map<dynamic, dynamic>();


  getUserData(String emailID) async{
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
      if(myMap['Liked'] == null)
        loginBloc.liked = [];
      else
        loginBloc.liked = myMap['Liked'];
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
      'Steps': {formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]) : 0}
    });
    sharedPreference.saveData(loginBloc.emailID);
  }

  updateUserData(Map map) async{
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.userMap['emailID']).update({
      'Age': map['Age'],
      'Weight': map['Weight'],
      'Height': map['Height'],
      'BMI': map['BMI'],
      'BMI Status': map['BMI Status'],
      'Steps Goal': map['Steps Goal']
    });
    await getUserData(loginBloc.userMap['emailID']);
  }

  saveUserSteps(String date, int steps) async{
    Map<String, dynamic> map = Map<String, dynamic>();
    try{
      DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(loginBloc.userMap['emailID']).get();
      map = ds.data()['Steps'];
      map[date]=steps;
      await FirebaseFirestore.instance.collection('users').doc(loginBloc.userMap['emailID']).update({
        'Steps' : map
      });
    }catch(e){}
  }

}
final userDataRepo = UserDataRepo();