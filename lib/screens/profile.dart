import 'package:flutter/material.dart';
import 'package:kilo/repository/user_register_repo.dart';
import 'package:kilo/screensize.dart';
import 'package:kilo/widgets/badges.dart';
import 'package:kilo/widgets/underline_text.dart';
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
                          Text(
                            "${loginBloc.userMap['Name']}​​",
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
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: badgeRow('First Exercise', img1, stream1, text2, img2, stream2),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
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
