import 'package:flutter/material.dart';
import 'package:kilo/bloc/activity_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/widgets/steps_indicator.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:kilo/repository/activity_repo.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();
    print([loginBloc.steps, loginBloc.userMap['Steps Goal']]);
    activityBloc.stepsIn.add([loginBloc.steps, loginBloc.userMap['Steps Goal']]);
    activityRepo.initialiseSteps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: underlineText('Dashboard', 24, Colors.black), 
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              stepsIndicator(context)
            ],
          ),
        ),
      ),
    );
  }
}