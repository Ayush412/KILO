import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/badges_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:date_format/date_format.dart';

class BadgesRepo{

  getBadgeData() async{
    int count = 0;
    int total = 0;
    var keys = [];
    List workouts = [
      'Endurance Easy',
      'Endurance Hard',
      'Endurance Medium',
      'Muscle Build Easy',
      'Muscle Build Hard',
      'Muscle Build Medium',
      'Weight Loss Easy',
      'Weight Loss Hard',
      'Weight Loss Medium'
    ];
    Map<dynamic, dynamic> map = Map<dynamic, dynamic>();
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).get();
    String date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

    //Total Steps
    map = ds.data()['Steps'];
    if(ds.data()['Steps'] == null)
      map = {date:0};
    keys = map.keys.toList()..sort();
    for (int i = 0; i<keys.length; i++)
      count = count + map[keys[i]];
    badgesBloc.stepsIn.add([count, 100000]);
    if(count>=100000)
      total += 1;

    //Total Cals
    count = 0;
    map = ds.data()['Cals'];
    if(ds.data()['Steps'] == null)
      map = {date:0};
    keys = map.keys.toList()..sort();
    for (int i = 0; i<keys.length; i++)
      count = count + (map[keys[i]]).round();
    badgesBloc.calsIn.add([count, 10000]);
    if(count>=10000)
      total += 1;

    keys = [];
    map = ds.data()['Workouts'];

    //First Workout
    count = 0;
    keys = map.keys.toList()..sort();
    for (int i = 0; i<keys.length; i++)
      count = count + map[keys[i]];
    if(count>0){
      badgesBloc.firstIn.add([1,1]);
      total += 1;
    }
    else
      badgesBloc.firstIn.add([0,1]);

    //All Workouts Completed
    count = 0;
    for (int i = 0; i<keys.length; i++){
      if(map[keys[i]]>0)
        count = count + 1;
    }
    badgesBloc.all3In.add([count,9]);
    if(count == 9)
      total += 1;

    //All Endurance
    count = 0;
    for (int i = 0; i<3; i++){
      if(map[workouts[i]]>0)
        count = count + 1;
    }
    print('End: $count');
    badgesBloc.endIn.add([count,3]);
    if(count == 3)
      total += 1;

    //All Muscle Build
    count = 0;
    for (int i = 3; i<6; i++){
      if(map[workouts[i]]>0)
        count = count + 1;
    }
    print('mb: $count');
    badgesBloc.mbIn.add([count,3]);
    if(count == 3)
      total += 1;

    //All Weight Loss
    count = 0;
    for (int i = 6; i<9; i++){
      if(map[workouts[i]]>0)
        count = count + 1;
    }
    print('wl: $count');
    badgesBloc.wlIn.add([count,3]);
    if(count == 9)
      total += 1;

    badgesBloc.allBadgesIn.add([total, 7]);
  }
}
final badgesRepo = BadgesRepo();