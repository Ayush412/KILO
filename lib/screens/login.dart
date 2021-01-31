import 'package:flutter/material.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/sharedpref.dart';
import 'package:page_transition/page_transition.dart';
import 'package:kilo/screensize.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:kilo/widgets/show_snack.dart';
import 'package:kilo/widgets/textfield.dart';
import 'package:kilo/widgets/circular_progress.dart';
import 'user_details.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Image img;

   Future checklogin() async{
    bool hasUser = true;
    bloc.loadingStatusIn.add(true);
    hasUser = await loginBloc.checkLogin();
    if(!hasUser)
      scaffoldKey.currentState.showSnackBar(showSnack('User not found', Colors.black, Colors.orange[400]));
    else{
      if(loginBloc.userMap!=null){
        //sharedPreference.saveData(loginBloc.emailID);
        navigate(context, HomeScreen(), PageTransitionType.rightToLeftWithFade);
      }
      else
        navigate(context, UserDetails(), PageTransitionType.rightToLeft);
    }
    bloc.loadingStatusIn.add(false);
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialogBox(context, 'Confirm exit', 'Do you wish tio exit the app?', null),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('login.jpg'), fit: BoxFit.cover)
              ),
              child: Stack(
                children:[
                  Container(
                    color: Colors.black.withOpacity(0.6),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: Image.asset('assets/KILO.png', height: screenSize(80, context)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10, bottom: 50),
                          child: Text("KILO", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          width: 300,
                          padding: EdgeInsets.all(10.0),
                            child: textField(loginBloc.emailCheck, loginBloc.emailChanged, 'Email', 'Email', Icon(Icons.person), TextInputType.emailAddress, false)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: Container(
                                      width: 300,
                                      padding: EdgeInsets.all(10.0),
                          child: textField(loginBloc.passCheck, loginBloc.passChanged, 'Password', 'Password', Icon(Icons.lock), TextInputType.text, true)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: StreamBuilder(
                            stream: loginBloc.credentialsCheck,
                            builder: (context, snap) => RaisedButton(
                              onPressed: snap.hasData? (){checklogin();} : () => scaffoldKey.currentState.showSnackBar(showSnack('Check all fields', Colors.black, Colors.orange[400])),
                              textColor: Colors.white,
                              color: Colors.orange[400],
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                              child: Container(
                                width: 250,
                                height: 55,
                                decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(80.0))
                                ),
                                child: Center(
                                  child: const Text('LOGIN', style: TextStyle(fontSize: 20, color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        circularProgressIndicator(context),
                        /*Padding(
                          padding: const EdgeInsets.only(top:20),
                          child: GestureDetector(
                            onTap: (){
                              //navigate(context, register());
                            },
                            child: Container(height:50,
                              child: Center(
                                child: Text('New user? Click here to register', 
                                  style: TextStyle(
                                    fontSize: 18.0, 
                                    color: Colors.black, 
                                    fontWeight: FontWeight.w400, 
                                    decoration: TextDecoration.underline
                                  )
                                )
                              )
                            )
                          ),
                        ),*/
                      ]),
                    )
                  ),
                ]
              ),
            ),
          ),
        )
      )
    );
  }
}