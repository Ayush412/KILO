import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../bloc.dart';
import 'login_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginBloc with ValidateCredentials implements BaseBloc{

  String emailID;
  String pass;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMessaging fbm = FirebaseMessaging();
  Map<dynamic, dynamic> userMap = Map<String, dynamic>();

  //CONTROLLERS
  BehaviorSubject<String> _emailController = BehaviorSubject();
  BehaviorSubject<String> _passwordController = BehaviorSubject();
  BehaviorSubject<Map> _userDetailsController = BehaviorSubject();
  final _loadingController = BehaviorSubject<bool>();

  //SINKS
  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passChanged => _passwordController.sink.add; 
  Sink<Map> get getDetails => _userDetailsController.sink;
  Sink<bool> get loadingStatusIn => _loadingController.sink;
  

  //STREAMS
  Stream<String> get emailCheck => _emailController.stream.transform(emailValidator);
  Stream<String> get passCheck => _passwordController.stream.transform(passValidator);
  Stream<bool> get credentialsCheck => Rx.combineLatest2(emailCheck, passCheck, (a, b) => true); 
  Stream<Map> get giveDetails => _userDetailsController.stream;
  Stream<bool> get loadingStatusOut => _loadingController.stream;

  checkLogin() async{
    var user;
    try{
      user = await _auth.signInWithEmailAndPassword(email: emailID, password: pass);
    }catch(e){print('Not found.');}
    if (user==null){
      return false;
    }
    else{
      await getUserData(emailID);
      return true;
    }
  }

  getData() async{
    await getUserData(emailID);
  }

  getUserData(String emailID) async{
    Map<String, dynamic> tempMap = Map<String, dynamic>();
    await FirebaseFirestore.instance.collection('users').doc(emailID).get().then((DocumentSnapshot snapshot){
      tempMap = snapshot.data();
    });
    if(tempMap==null)
      userMap=null;
    else{
      userMap.putIfAbsent('emailID', () => emailID);
      userMap = tempMap;
      fbm.subscribeToTopic(userMap['ID']);
    }
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _userDetailsController.close();
    _loadingController.close();
  }
}

final loginBloc = LoginBloc();