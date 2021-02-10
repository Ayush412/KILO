import 'package:flutter/material.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/bloc/register/register_bloc.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/repository/user_register_repo.dart';
import 'package:kilo/sharedpref.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:kilo/widgets/progress_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:kilo/screensize.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:kilo/widgets/show_snack.dart';
import 'package:kilo/widgets/textfield.dart';
import 'user_details.dart';
import 'package:connectivity/connectivity.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Image img;
  static final controller = PageController(initialPage: 0);
  double page;

  Future checkLogin() async{
    dynamic hasUser = true;
    var conn = await (Connectivity().checkConnectivity());
    if(conn == ConnectivityResult.none)
       scaffoldKey.currentState.showSnackBar(showSnack('No internet connection!', Colors.white, Colors.red[700]));
    else{
      bloc.loadingStatusIn.add(true);
      hasUser = await loginBloc.checkLogin();
      bloc.loadingStatusIn.add(false);
      if(!hasUser)
        scaffoldKey.currentState.showSnackBar(showSnack('User not found.', Colors.black, Colors.orange[400]));
      else{
        if(loginBloc.userMap!=null){
          sharedPreference.saveData(loginBloc.emailID);
          navigate(context, HomeScreen(), PageTransitionAnimation.slideRight, true);
        }
        else
          navigate(context, UserDetails(), PageTransitionAnimation.slideRight, false);
      }
    }
  }

  Future checkNewLogin() async{
    bool user;
    var conn = await (Connectivity().checkConnectivity());
    if(conn == ConnectivityResult.none)
       scaffoldKey.currentState.showSnackBar(showSnack('No internet connection!', Colors.white, Colors.red[700]));
    else{
      bloc.loadingStatusIn.add(true);
      user = await registerBloc.createLogin();
      if(user){
        showDialogBox(context, 'Verification', 'An email has been sent to you. Please verify your email address.', 1);
      }
      else
        scaffoldKey.currentState.showSnackBar(showSnack('User already exists', Colors.black, Colors.orange[400]));
      bloc.loadingStatusIn.add(false);
    }
  }

  Future googleLogin() async{
    var conn = await (Connectivity().checkConnectivity());
    if(conn == ConnectivityResult.none)
       scaffoldKey.currentState.showSnackBar(showSnack('No internet connection!', Colors.white, Colors.red[700]));
    else{
      await userRegisterRepo.googleLogin();
      bloc.loadingStatusIn.add(false);
      if(loginBloc.userMap!=null){
        sharedPreference.saveData(loginBloc.emailID);
        navigate(context, HomeScreen(), PageTransitionAnimation.slideRight, true);
      }
      else
        navigate(context, UserDetails(), PageTransitionAnimation.slideRight, false);
    }
  }

  @override
  void initState() {
    super.initState();
    bloc.loadingStatusIn.add(false);
    page=0;
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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: page==1? Text('Register', style: TextStyle(color: Colors.white, fontSize: 24),) : null,
            leading: page==1 ? 
              GestureDetector(
                onTap: (){
                  controller.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.linear);
                  setState(() {
                    page = 0;
                  });
                },
                child: Icon(Icons.arrow_back, color: Colors.white, size: 34,))
              : null
          ),
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
                  PageView(
                    controller: controller,
                    physics: NeverScrollableScrollPhysics(),
                    allowImplicitScrolling: false,
                    children: [
                      SingleChildScrollView(
                        child: Center(
                          child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Image.asset('assets/KILO.png', height: screenSize(80, context)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10, bottom: 50),
                              child: Text("KILO", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:[
                                    Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
                                    Container(
                                      width: screenSize(300, context),
                                      padding: EdgeInsets.all(5.0),
                                      child: textField(loginBloc.emailCheck, loginBloc.emailChanged, 'Email', null, TextInputType.emailAddress, false, false)
                                    ),
                                    Container(
                                      width: screenSize(300, context),
                                      padding: EdgeInsets.all(5.0),
                                      child: textField(loginBloc.passCheck, loginBloc.passChanged, 'Password', null, TextInputType.text, true, false)
                                    ),
                                    RaisedButton(
                                      onPressed: () => googleLogin(),
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      child: Container(
                                        width: screenSize(200, context),
                                        height: screenSize(35, context),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: screenSize(25, context),
                                              width: screenSize(25, context),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage('google.jpg'),
                                                  fit: BoxFit.cover
                                                ),
                                                shape: BoxShape.circle
                                              ),
                                            ),
                                            Text("Sign in with Google", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),)
                                          ],
                                        ),
                                      ),
                                    )
                                  ]
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: StreamBuilder(
                                stream: bloc.loadingStatusOut,
                                builder: (context, index){
                                  if(index.hasData && index.data==true)
                                    return SizedBox(
                                      height: screenSize(42.5, context),
                                      child: progressIndicator(context)
                                    );
                                  else if(!index.hasData || index.data==false)
                                    return StreamBuilder(
                                      stream: loginBloc.credentialsCheck,
                                      builder: (context, snap) => RaisedButton(
                                        onPressed: snap.hasData? (){checkLogin();} : () => scaffoldKey.currentState.showSnackBar(showSnack('Check all fields', Colors.black, Colors.orange[400])),
                                        textColor: Colors.white,
                                        color: Colors.orange[400],
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                        child: Container(
                                          width: screenSize(250, context),
                                          height: screenSize(40, context),
                                          decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(80.0))
                                          ),
                                          child: Center(
                                            child: const Text('LOGIN', style: TextStyle(fontSize: 20, color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    );
                                }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:20),
                              child: GestureDetector(
                                onTap: (){
                                  controller.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.linear);
                                  setState(() {
                                    page = 1;
                                  });
                                },
                                child: Container(height:50,
                                  child: Center(
                                    child: underlineText('Create Account', 18)
                                  )
                                )
                              ),
                            ),
                          ]),
                        )
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:80),
                              child: Container(
                                          width: 300,
                                          padding: EdgeInsets.all(10.0),
                              child: textField(registerBloc.emailCheck, registerBloc.emailChanged, 'Email', null, TextInputType.emailAddress ,false, false)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:30),
                              child: Container(
                                          width: 300,
                                          padding: EdgeInsets.all(10.0),
                              child: textField(registerBloc.pass1Check, registerBloc.pass1Changed, 'Password', null, TextInputType.text, true, false)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:30),
                              child: Container(
                                          width: 300,
                                          padding: EdgeInsets.all(10.0),
                              child: textField(registerBloc.pass2Check, registerBloc.pass2Changed, 'Re-type password', null, TextInputType.text, true, false)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: StreamBuilder(
                                stream: bloc.loadingStatusOut,
                                builder: (context, index){
                                  if(index.hasData && index.data==true)
                                    return SizedBox(
                                      height: screenSize(42.5, context),
                                      child: progressIndicator(context)
                                    );
                                  else if(!index.hasData || index.data==false)
                                    return StreamBuilder(
                                      stream: registerBloc.credentialsCheck,
                                      builder: (context, snap) => RaisedButton(
                                        onPressed: snap.hasData? (){checkNewLogin();} : () => scaffoldKey.currentState.showSnackBar(showSnack('Check all fields', Colors.black, Colors.orange[400])),
                                        textColor: Colors.white,
                                        color: Colors.orange[400],
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                        child: Container(
                                          width: screenSize(250, context),
                                          height: screenSize(40, context),
                                          decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(80.0))
                                          ),
                                          child: Center(
                                            child: const Text('REGISTER', style: TextStyle(fontSize: 20, color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    );
                                }
                              ),
                            ),
                          ],
                        ),
                      )
                    ]
                  ),
                ]
              ),
            ),
          ),
        ),
      )
    );
  }
}