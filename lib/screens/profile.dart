import 'package:flutter/material.dart';
import 'package:kilo/bloc/badges_bloc.dart';
import 'package:kilo/repository/user_register_repo.dart';
import 'package:kilo/screensize.dart';
import 'package:kilo/widgets/badges.dart';
import 'package:kilo/bloc/login/login_bloc.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  logOut() async {
    await userRegisterRepo.logOut(context);
  }

  @override
  void initState() { 
    super.initState();
    badgesBloc.getBadgeData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(15)
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 50.0,
                            child: Image(
                              image: AssetImage('KILO.png'),
                              height: 70,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "${loginBloc.userMap['Name']}​​",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height:30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children:[
                                  Text('Age', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                                  Text('${loginBloc.userMap['Age']}', style: TextStyle(fontSize: 23, color: Colors.orange[400], fontWeight: FontWeight.w500)),
                                  SizedBox(height:20),
                                  Text('Weight', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                                  Text('${loginBloc.userMap['Weight']} kg', style: TextStyle(fontSize: 23, color: Colors.orange[400], fontWeight: FontWeight.w500))
                                ]
                              ),
                              Container(
                                width: 2,
                                height: 50,
                                color: Colors.white,
                              ),
                              Column(
                                children:[
                                  Text('Height', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                                  Text('${loginBloc.userMap['Height']} cm', style: TextStyle(fontSize: 23, color: Colors.orange[400], fontWeight: FontWeight.w500)),
                                  SizedBox(height:20),
                                  Text('BMI', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                                  Text('${loginBloc.userMap['BMI']}', style: TextStyle(fontSize: 23, color: Colors.orange[400], fontWeight: FontWeight.w500))
                                ]
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Badges Earned", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: badgeRow(context,
                    'Gym Rat', 'Burn 10k Calories', 'olympic_badge.png', badgesBloc.calsOut, 
                    'Machine', 'Reach 100k Steps', 'steps_badge.png', badgesBloc.stepsOut
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: badgeRow(context,
                    'Baby Steps', 'Complete Your 1st Workout', 'winner_badge.png', badgesBloc.firstOut, 
                    'Fitneek', 'Complete All Weight Loss Workouts', 'medal_badge.png', badgesBloc.wlOut
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: badgeRow(context,
                    'Hulk', 'Complete All Muscle Build Workouts', 'trophy_badge.png', badgesBloc.mbOut, 
                    'Tenacity', 'Complete All Endurance Workouts', 'mountain_badge.png', badgesBloc.endOut
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: badgeRow(context,
                    'All Star', 'Complete All Workouts', 'award_badge.png', badgesBloc.all3Out,
                    'Mad Lad', 'Unlock All Badges', 'finish_badge.png', badgesBloc.allBadgesOut, 
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                  child: Container(
                    height: 50,
                    width: screenSize(150, context),
                    child: RaisedButton(
                      color: Colors.orange[400],
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () => logOut(),
                      child: Text("Logout",
                          style: TextStyle(color: Colors.white)
                      )
                    ),
                  )
                )
              ],
            )
          )
        ),
      )
    );
  }
}
