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
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  setRecognitions(recognitions, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
    print('yeeted $recognitions');
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
    List text = widget.pose.toUpperCase().split('_');
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('${text[0]} ${text[1]}'),
      ),
      body: Stack(
        children: [
          Camera(
            cameras: widget.cameras,
            setRecognitions: setRecognitions),
          PosenetPoints(results: _recognitions == null ? [] : _recognitions,
            previewH: math.max(_imageHeight, _imageWidth),
            previewW: math.min(_imageHeight, _imageWidth),
            screenH: screen.height,
            screenW: screen.width,
            pose: widget.pose)
        ],
      ),
    );
  }
}