import 'package:flutter/material.dart';
import 'package:kilo/repository/user_register_repo.dart';
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
              Container(
                  // decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //     begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  // colors: [Colors.white])),
                  // colors: [Colors.orangeAccent, Colors.deepOrange])),
                  child: Container(
                width: double.infinity,
                height: 160.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/kilo-a719c.appspot.com/o/puppy.jpeg?alt=media&token=6946cd13-6d78-4d98-a997-caa6ac1aa4d9",
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${loginBloc.userMap['Name']}​​",
                        style: TextStyle(
                          color: Colors.white,
                          // color: Colors.deepOrangeAccent[700],
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
              )),
              SizedBox(
                height: 10.0,
              ),
              Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.grey[800],
                  elevation: 5.0,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 22.0),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Age",
                                style: TextStyle(
                                  color: Colors.orange[400],
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                "${loginBloc.userMap['Age']}​​",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[400],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]))),
              SizedBox(
                height: 10.0,
              ),
              Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.grey[800],
                  elevation: 5.0,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 22.0),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Weight (kg)",
                                style: TextStyle(
                                  color: Colors.orange[400],
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                "${loginBloc.userMap['Weight']}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[400],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]))),
              SizedBox(
                height: 10.0,
              ),
              Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.grey[800],
                  elevation: 5.0,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 22.0),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Height (cm)",
                                style: TextStyle(
                                  color: Colors.orange[400],
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                "${loginBloc.userMap['Height']}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[400],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]))),
              SizedBox(
                height: 10.0,
              ),
              Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.grey[800],
                  elevation: 5.0,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 22.0),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "BMI",
                                style: TextStyle(
                                  color: Colors.orange[400],
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                "${loginBloc.userMap['BMI']}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[400],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]))),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: 200.00,
                child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    elevation: 0.0,
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.deepOrangeAccent,
                              Colors.deepOrangeAccent
                            ]),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Badges",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
                  child: RaisedButton(
                      color: Colors.white,
                      elevation: 1,
                      onPressed: () => logOut(),
                      child: Text("Logout",
                          style: TextStyle(color: Colors.deepOrange))))
            ],
          ))),
        ));
  }
}
