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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('steps', steps);
  }
  resetSteps() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('steps', 0);
  }
  saveStepsDate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stepsDate', date);
  }
  setGFitAccess(var val) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('GFit', val);
  }
}

final sharedPreference = SharedPreference();