import 'package:flutter/material.dart';
import 'package:kilo/bloc/activity_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/repository/activity_repo.dart';
import 'package:kilo/screens/dashboard.dart';
import 'package:kilo/screens/feed.dart';
import 'package:kilo/screens/record_activity.dart';
import 'package:kilo/screens/profile.dart';
import 'package:kilo/screens/wallet.dart';
import 'package:kilo/screens/wallet_upi.dart';
import 'package:kilo/sharedpref.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:kilo/screens/calories/calories.dart';
import 'package:kilo/screens/calories/calories_section.dart';
import 'package:health/health.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  PersistentTabController controller = PersistentTabController(initialIndex: 1);
  
  List<PersistentBottomNavBarItem> navbarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.share_rounded),
        title: ("Feed"),
        activeColor: Colors.orange[400],
        inactiveColor: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Dashboard"),
        activeColor: Colors.orange[400],
        inactiveColor: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.dumbbell),
        title: ("Workouts"),
        activeColor: Colors.orange[400],
        inactiveColor: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColor: Colors.orange[400],
        inactiveColor: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.wallet_giftcard),
        title: ("Wallet"),
        activeColor: Colors.orange[400],
        inactiveColor: Colors.grey[600],
      ),
    ];
  }

  List<Widget> screens() {
    return [Feed(), Dashboard(), Record(), Profile(), Wallet(),];
  }

  getChartData() async{
    await activityBloc.getChartData('Steps', activityBloc.stepsChartIn);
    await activityBloc.getChartData('Cals', activityBloc.calsChartIn);
  }

  @override
  void initState() {
    super.initState();
    activityRepo.getFitData();
    activityRepo.initialiseSteps();
    activityBloc.stepsIn.add(loginBloc.steps);
    getChartData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialogBox(context, 'Exit App?', '', null),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: PersistentTabView(
            context,
            controller: controller,
            confineInSafeArea: true,
            resizeToAvoidBottomInset: true,
            hideNavigationBarWhenKeyboardShows: true,
            items: navbarItems(),
            screens: screens(),
            backgroundColor: Colors.black,
            handleAndroidBackButtonPress: true,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            navBarStyle: NavBarStyle.style14,
          )),
    );
  }
}