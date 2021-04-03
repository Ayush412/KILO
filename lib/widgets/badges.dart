import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

badgeRow(String text1, String descp1, String img1, Stream stream1, String text2, String descp2, String img2, Stream stream2){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: StreamBuilder(
          stream: stream1,
          builder: (context, snapshot) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                
              ),
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: StreamBuilder(
          stream: stream2,
          builder: (context, snapshot) {
            return Container(
              
            );
          },
        ),
      )
    ],
  );
}