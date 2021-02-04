import 'package:flutter/material.dart';

underlineText(String text, double size){
  return Text(
    text,
    style: TextStyle(
      shadows: [Shadow(
        color: Colors.white,
        offset: Offset(0,-10)
      )],
      color: Colors.transparent, 
      fontSize: size, 
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
      decorationColor: Colors.orange[400],
      decorationThickness: 3
    )
  );
}