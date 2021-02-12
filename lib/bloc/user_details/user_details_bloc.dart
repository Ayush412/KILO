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
  String weight;
  Color color;
  double bmi;
  String bmiStatus;
  int height;
  int w;
  Map<dynamic, dynamic> userMap = Map<dynamic, dynamic>();

  UserDetailsBloc(){
    nameController.stream.listen((event) {name=event;});
    ageController.stream.listen((event) {age=event;});
    weightController.stream.listen((event) {weight=event;});
    heightOut.listen((event) {
      height = event;
      getBMI();
    });
  }
  
  //CONTROLLERS
  BehaviorSubject<String> nameController = BehaviorSubject();
  BehaviorSubject<String> ageController = BehaviorSubject();
  BehaviorSubject<String> weightController = BehaviorSubject();
  BehaviorSubject<int> heightController = BehaviorSubject();
  BehaviorSubject<double> bmiController = BehaviorSubject();
  BehaviorSubject<String> bmiStatusController = BehaviorSubject();

  //SINKS
  Function(String) get nameChanged => nameController.sink.add;
  Function(String) get ageChanged => ageController.sink.add;
  Function(String) get weightChanged => weightController.sink.add;
  Sink<int> get heightIn => heightController.sink;
  Sink<double> get bmiIn => bmiController.sink;
  Sink<String> get bmiStatusIn => bmiStatusController.sink;

  //STREAMS
  Stream<String> get nameCheck => nameController.stream.transform(nameValidator);
  Stream<String> get ageCheck => ageController.stream.transform(ageValidator);
  Stream<String> get weightCheck => weightController.stream.transform(weightValidator);
  Stream<int> get heightOut => heightController.stream;
  Stream<double> get bmiOut => bmiController.stream;
  Stream<String> get bmiStatusOut => bmiStatusController.stream;
  Stream<bool> get credentialsCheck => Rx.combineLatest3(nameCheck, ageCheck, weightCheck, (a, b, c) => true);

  calculateBMI(){
    getBMI();
    bmiIn.add(bmi);
    bmiStatusIn.add(bmiStatus);
  }

  getBMI(){
    if(weight=='' || weight==null ){}
    else{
      w = int.parse(weight);
      if(height>0 && w>0){
        bmi = (w/(height*height))*10000;
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
    Map map = {"Name":name, "Age": age, "Weight": weight, "Height":height, "BMI": bmi, "BMI Status": bmiStatus};
    await userDataRepo.saveUserData(map);
  }

  updateUserData() async{
    Map map = {
      "Age": age==null? loginBloc.userMap['Age'] : age, 
      "Weight": weight==null? loginBloc.userMap['Weight'] : weight,
      "Height": height==null? loginBloc.userMap['Height'] : height,
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