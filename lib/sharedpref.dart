import 'package:kilo/bloc/activity_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';

class SharedPreference{

  String date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  saveData(String emailID) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('email', emailID);
  }
  removeData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
  }
  openApp() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('open', true);
  }
  saveSteps(int steps) async{
    loginBloc.steps = steps;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('steps', steps);
  }
  resetSteps() async{
    loginBloc.steps = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('steps', 0);
  }
  saveActivityDate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('activityDate', date);
  }
  setGFitAccess(var val) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('GFit', val);
  }
  saveCals(double cals) async{
    activityBloc.totalCals = cals;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('cals', cals);
  }
  resetCals() async{
    activityBloc.totalCals = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('cals', 0);
  }
}

final sharedPreference = SharedPreference();