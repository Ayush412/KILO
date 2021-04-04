import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

badgeRow(BuildContext context, String text1, String descp1, String img1, Stream stream1, String text2, String descp2, String img2, Stream stream2){
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: StreamBuilder(
            stream: stream1,
            builder: (context, snap1) {
              List data1 = snap1.data;
              if(snap1.data == null)
                data1 = [0,0];
              return display(context, text1, descp1, img1, data1);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: StreamBuilder(
            stream: stream2,
            builder: (context, snap2) {
              List data2 = snap2.data;
              if(snap2.data == null)
                data2 = [0,0];
              return display(context, text2, descp2, img2, data2);
            },
          ),
        )
      ],
    ),
  );
}

display(BuildContext context, String text, String descp, String img, List data){
  var formatter = NumberFormat('###,###');
  return Container(
    width: MediaQuery.of(context).size.width/2.5,
    decoration: BoxDecoration(
      color: Colors.grey[800],
      borderRadius: BorderRadius.circular(15)
    ),
    padding: const EdgeInsets.all(15),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 20),
          CircularPercentIndicator(
            radius: MediaQuery.of(context).size.width/3.5,
            backgroundWidth: 8,
            lineWidth: 8,
            percent: data==null? 0 : data[0]/data[1]>=1 ? 1 : data[0]/data[1],
            animationDuration: 1500,
            backgroundColor: Colors.grey,
            progressColor: data[0]==data[1]? Colors.green : Colors.orange[400],
            center: Image.asset('assets/$img', height: MediaQuery.of(context).size.width/3.8,)
          ),
          SizedBox(height: 20),
          Text(
            '${formatter.format(data[0])}/${formatter.format(data[1])}', 
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 10),
          Text(
            descp, 
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold)
          ),
        ],
      ),
    ),
  );
}