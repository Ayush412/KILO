import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

navigate(BuildContext context, dynamic className, PageTransitionType type){
  Navigator.push(context, PageTransition(
    type: type,
    child: className,
  ));
}