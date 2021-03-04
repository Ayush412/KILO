import 'package:flutter/material.dart';
import 'package:kilo/screensize.dart';
import 'package:kilo/widgets/underline_text.dart';

class Yoga extends StatefulWidget {
  @override
  _YogaState createState() => _YogaState();
}

class _YogaState extends State<Yoga> {

  List poses = ['high_lunge', 'tree_pose', 'triangle_pose'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: underlineText('YOGA', 24, Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index){
              List text = (poses[index].toString().toUpperCase()).split('_');
              return GestureDetector(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: screenSize(250, context),
                    width: screenSize(100, context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(image:AssetImage('${poses[index]}.jpg'))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${text[0]} ${text[1]}', style: TextStyle(color: Colors.black, fontSize: 25),)
                      ],
                    ),
                  ),
                ),
              );
            },
        ),
      ),
    );
  }
}