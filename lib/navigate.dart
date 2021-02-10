import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:page_transition/page_transition.dart';

navigate(BuildContext context, dynamic className, PageTransitionAnimation type, bool nav){
  pushNewScreen(
    context, 
    screen: className, 
    withNavBar: nav,
    pageTransitionAnimation: type
  );
}