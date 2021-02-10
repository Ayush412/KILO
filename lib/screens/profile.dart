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
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: underlineText('My Profile', 21), 
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
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