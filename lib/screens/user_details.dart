import 'package:flutter/material.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/widgets/progress_indicator.dart';
import 'package:kilo/widgets/show_snack.dart';
import '../screensize.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:kilo/widgets/textfield.dart';
import 'package:kilo/bloc/user_details/user_details_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'home.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  checkData() async{
    bloc.loadingStatusIn.add(true);
    await userDetailsBloc.saveUserData();
    bloc.loadingStatusIn.add(false);
    navigate(context, HomeScreen(), PageTransitionType.fade);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetailsBloc.bmiIn.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialogBox(context, '', 'Return to login?', 'login'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: scaffoldKey,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: ColorfulSafeArea(
              color: Colors.grey[900],
              child:
              Stack(
                children: [
                  Container(
                    color: Colors.grey[900],
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:30, bottom: 30),
                            child: underlineText('Personal Details', 24)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
                            child: textField(userDetailsBloc.nameCheck, userDetailsBloc.nameChanged, 'Name', Icon(Icons.person), TextInputType.text, false, false),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
                            child: textField(userDetailsBloc.ageCheck, userDetailsBloc.ageChanged, 'Age', Icon(Icons.cake), TextInputType.number, false, true),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
                            child: textField(userDetailsBloc.weightCheck, userDetailsBloc.weightChanged, 'Weight (kg)', Icon(FontAwesomeIcons.weight), TextInputType.number, false, true),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
                            child: textField(userDetailsBloc.heightCheck, userDetailsBloc.heightChanged, 'Height (cm)', Icon(FontAwesomeIcons.ruler), TextInputType.number, false, true),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child:  RaisedButton(
                              onPressed: () => userDetailsBloc.calculateBMI(),
                              color: Colors.orange[400],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                              child: Text("Calculate BMI:", style: TextStyle(color: Colors.white, fontSize: 20),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: StreamBuilder(
                                stream: userDetailsBloc.bmiOut,
                                builder: (context, bmi) {
                                  if(bmi.data!=null){
                                    return CircularPercentIndicator(
                                      radius: 120,
                                      percent: bmi.data/45,
                                      animationDuration: 1200,
                                      backgroundColor: Colors.black,
                                      progressColor: userDetailsBloc.color,
                                      center: Text(bmi.data.toString(), style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                                    );
                                  }
                                  else
                                    return Container();
                                },
                              ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: StreamBuilder(
                              stream: userDetailsBloc.bmiStatusOut ,
                              builder: (context, status){
                                if(status.data!=null){
                                  return Text(status.data, style: TextStyle(
                                    color: userDetailsBloc.color,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold
                                  ));
                                }
                                else
                                return Container();
                              },
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 50, bottom: 70),
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
                                      stream: userDetailsBloc.credentialsCheck,
                                      builder: (context, snap) => RaisedButton(
                                        onPressed: snap.hasData? () => checkData() : () => scaffoldKey.currentState.showSnackBar(showSnack('Check all fields', Colors.black, Colors.orange[400])),
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
                        ]
                      ),
                    )
                  )
                ]
              )
            )
          ),
        ),
      ),
    );
  }
}