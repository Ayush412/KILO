import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';

class UserDataRepo{
  
  Map<dynamic, dynamic> myMap = Map<dynamic, dynamic>();


  getUserData(String emailID) async{
    await FirebaseFirestore.instance.collection('users').doc(emailID).get().then((DocumentSnapshot snapshot){
      myMap = snapshot.data();
    });
    if(myMap==null){
      print('no data');
      loginBloc.userMap=null;
    }
    else{
      print('yes data');
      myMap.putIfAbsent('emailID', () => emailID);
      loginBloc.userMap = myMap;
    }
  }

  saveUserData(Map map) async{
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).set({
      'Name': map['Name'],
      'Age': map['Age'],
      'Weight': map['Weight'],
      'BMI': map['BMI'],
      'BMI Status': map['BMI Status'],
      'Admin': 0,
    });
    //sharedPreference.saveData(loginBloc.emailID);
  }

  updateUserData(Map map) async{
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.userMap['emailID']).update({
      'Age': map['Age'],
      'Weight': map['Weight'],
      'BMI': map['BMI'],
      'BMI Status': map['BMI Status']
    });
    await getUserData(loginBloc.userMap['emailID']);
  }

}
final userDataRepo = UserDataRepo();