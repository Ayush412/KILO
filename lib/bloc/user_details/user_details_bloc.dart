import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/bloc/user_details/user_details_validator.dart';
import 'package:kilo/repository/user_data_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class UserDetailsBloc with ValidateDetails implements BaseBloc{

  String name;
  String age;
  String height;
  String weight;
  Color color;
  double bmi;
  String bmiStatus;
  int h;
  int w;
  Map<dynamic, dynamic> userMap = Map<dynamic, dynamic>();

  UserDetailsBloc(){
    nameController.stream.listen((event) {name=event;});
    ageController.stream.listen((event) {age=event;});
    weightController.stream.listen((event) {weight=event;});
    heightController.stream.listen((event) {height=event;});
  }
  
  //CONTROLLERS
  BehaviorSubject<String> nameController = BehaviorSubject();
  BehaviorSubject<String> ageController = BehaviorSubject();
  BehaviorSubject<String> weightController = BehaviorSubject();
  BehaviorSubject<String> heightController = BehaviorSubject();
  BehaviorSubject<double> bmiController = BehaviorSubject();
  BehaviorSubject<String> bmiStatusController = BehaviorSubject();

  //SINKS
  Function(String) get nameChanged => nameController.sink.add;
  Function(String) get ageChanged => ageController.sink.add;
  Function(String) get weightChanged => weightController.sink.add;
  Function(String) get heightChanged => heightController.sink.add;
  Sink<double> get bmiIn => bmiController.sink;
  Sink<String> get bmiStatusIn => bmiStatusController.sink;

  //STREAMS
  Stream<String> get nameCheck => nameController.stream.transform(nameValidator);
  Stream<String> get ageCheck => ageController.stream.transform(ageValidator);
  Stream<String> get weightCheck => weightController.stream.transform(weightValidator);
  Stream<String> get heightCheck => heightController.stream.transform(heightValidator);
  Stream<double> get bmiOut => bmiController.stream;
  Stream<String> get bmiStatusOut => bmiStatusController.stream;
  Stream<bool> get credentialsCheck => Rx.combineLatest4(nameCheck, ageCheck, weightCheck, heightCheck, (a, b, c, d) => true);

  calculateBMI(){
    getBMI();
    bmiIn.add(bmi);
    bmiStatusIn.add(bmiStatus);
  }

  getBMI(){
    if(weight=='' || weight==null || height=='' || height==null){}
    else{
      h = int.parse(height);
      w = int.parse(weight);
      if(h>0 && w>0){
        bmi = (w/(h*h))*10000;
        bmi = num.parse(bmi.toStringAsFixed(1));
      }
      if (bmi >= 25.0 && bmi < 29.9){
        bmiStatus = "Overweight";
        color = Colors.orange[400];
      }
      else if (bmi >= 18.5 && bmi < 25.0){
        bmiStatus = "Healthy";
        color = Colors.green[400];
      }
      else if (bmi >= 29.9){
        bmiStatus = "Obese";
        color = Colors.red[400];
      }
      else{
        bmiStatus = "Underweight";
        color = Colors.orange[400];
      }
      print(bmi);
    }
  }

  saveUserData() async{
    Map map = {"Name":name, "Age": age, "Weight": weight, "BMI": bmi, "BMI Status": bmiStatus};
    await userDataRepo.saveUserData(map);
  }

  updateUserData() async{
    Map map = {
      "Age": age==null? loginBloc.userMap['Age'] : age, 
      "Weight": weight==null? loginBloc.userMap['Weight'] : weight,
      "BMI": bmi==null? loginBloc.userMap['BMI'] : bmi,
      "BMI Status": bmiStatus==null? loginBloc.userMap['BMI Status'] : bmiStatus,
    };
    await userDataRepo.updateUserData(map);
  }
  
  @override
  void dispose() {
    nameController.close();
    ageController.close();
    weightController.close();
    heightController.close();
    bmiController.close();
    bmiStatusController.close();
  }
}

final userDetailsBloc = UserDetailsBloc();