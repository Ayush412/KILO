import 'package:flutter/material.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Feed',
      style: optionStyle,
    ),
    Text(
      'Index 1: Explore',
      style: optionStyle,
    ),
    Text(
      'Index 2: Record Activity',
      style: optionStyle,
    ),
    Text(
      'Index 3: Payments',
      style: optionStyle,
    ),
    Text(
      'Index 4: Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () =>
            showDialogBox(context, '', 'Return to login?', 'login'),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            key: scaffoldKey,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.grey[800],
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.server),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.dumbbell),
                  label: 'Activity',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.wallet),
                  label: 'Payments',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.addressCard),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              unselectedItemColor: Colors.black,
              onTap: _onItemTapped,
            ),
            body: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
                child: ColorfulSafeArea(
                  color: Colors.grey[900],
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.grey[900],
                        child: Center(
                          child: Image.asset("KILO.png", height: 100),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}
