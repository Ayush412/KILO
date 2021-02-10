import 'package:flutter/material.dart';
import 'package:kilo/screens/dashboard.dart';
import 'package:kilo/screens/profile.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> navbarItems(){
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Dashboard"),
        activeColor: Colors.orange[400],
        inactiveColor: Colors.grey[800],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColor: Colors.orange[400],
        inactiveColor: Colors.grey[800],
      ),
    ];
  }

  List<Widget> screens(){
    return [
      Dahsboard(),
      Profile()
    ];
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
          navBarStyle: NavBarStyle.style9,
        ) 
      ),
    );
  }
}
