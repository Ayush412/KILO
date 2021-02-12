import 'package:flutter/material.dart';
import 'package:kilo/repository/user_register_repo.dart';
import 'package:kilo/widgets/underline_text.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  logOut() async{
    await userRegisterRepo.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: underlineText('My Profile', 21, Colors.black), 
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Colors.white,
                  elevation: 1,
                  onPressed: () => logOut(),
                  child: Text("Logout")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}