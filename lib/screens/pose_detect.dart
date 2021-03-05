import 'package:flutter/material.dart';
import 'package:kilo/widgets/camera.dart';
import 'package:kilo/widgets/posenet_points.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';
import 'dart:math' as math;

class Posedetect extends StatefulWidget {
  String pose;
  List<CameraDescription> cameras;
  Posedetect({this.pose, this.cameras});
  @override
  _PosedetectState createState() => _PosedetectState();
}

class _PosedetectState extends State<Posedetect> {
  List<dynamic> recognitions;
  int imageHeight = 0;
  int imageWidth = 0;

  setRecognitions(recognitions, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      recognitions = recognitions;
      imageHeight = imageHeight;
      imageWidth = imageWidth;
    });
    print(recognitions);
  }

   loadModel() async {
    return await Tflite.loadModel(
      model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
    );
  }

  @override
  void initState() {
    super.initState();
    var res = loadModel();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(widget.pose),
      ),
      body: Stack(
        children: [
          Camera(
            cameras: widget.cameras,
            setRecognitions: setRecognitions),
          PosenetPoints(results: recognitions == null ? [] : recognitions,
            previewH: math.max(imageHeight, imageWidth),
            previewW: math.min(imageHeight, imageWidth),
            screenH: screen.height,
            screenW: screen.width,
            pose: widget.pose)
        ],
      ),
    );
  }
}