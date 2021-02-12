import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
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
      'Liked': []
    });
    sharedPreference.saveData(loginBloc.emailID);
  }

  updateUserData(Map map) async{
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.userMap['emailID']).update({
      'Age': map['Age'],
      'Weight': map['Weight'],
      'Height': map['Height'],
      'BMI': map['BMI'],
      'BMI Status': map['BMI Status']
    });
    await getUserData(loginBloc.userMap['emailID']);
  }

}
final userDataRepo = UserDataRepo();