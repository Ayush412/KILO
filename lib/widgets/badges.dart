import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

badgeRow(String text1, String img1, Stream stream1, String text2, String img2, Stream stream2){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      StreamBuilder(
        stream: stream1,
        builder: (context, snapshot) {
          return Container(
            
          );
        },
      )
    ],
  );
}