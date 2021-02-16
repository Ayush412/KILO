import 'package:flutter/material.dart';
import 'package:kilo/screens/dashboard.dart';
import 'package:kilo/screens/feed.dart';
import 'package:kilo/screens/record_activity.dart';
import 'package:kilo/screens/profile.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:kilo/screens/programs.dart';



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
        icon: Icon(Icons.lock_clock),
        title: ("Record"),
        activeColor: Colors.orange[400],
        inactiveColor: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColor: Colors.orange[400],
        inactiveColor: Colors.grey[600],
      ),
    ];
  }

  List<Widget> screens() {
            controller: controller,
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