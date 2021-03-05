import 'package:flutter/material.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/screens/pose_detect.dart';
import 'package:kilo/screensize.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:camera/camera.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Yoga extends StatefulWidget {
  @override
  _YogaState createState() => _YogaState();
}

class _YogaState extends State<Yoga> {
  List<CameraDescription> cameras;
  List poses = ['high_lunge', 'tree_pose', 'triangle_pose'];

  checkCams() async{
    try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  }

  @override
  void initState() {
    super.initState();
    checkCams();
  }

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
                onTap: (){
                  navigate(
                    context, 
                    Posedetect(pose:poses[index], cameras: cameras), 
                    PageTransitionAnimation.slideRight, 
                    false
                  );
                },
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