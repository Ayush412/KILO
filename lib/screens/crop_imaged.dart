import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_image_crop/simple_image_crop.dart';

typedef void Callback(dynamic file);
class CropScreen extends StatefulWidget {
  var file;
  final Callback onDone;
  CropScreen({this.file, this.onDone});
  @override
  _CropScreenState createState() => new _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final cropKey = GlobalKey<ImgCropState>();

  done() async{
    final crop = cropKey.currentState;
    final croppedFile = await crop.cropCompleted(widget.file, preferredSize: 1000);
    widget.onDone(croppedFile);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Zoom and Crop',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon:
                new Icon(Icons.arrow_back, color: Colors.black, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              onPressed: ()=> done(),
              icon: Icon(Icons.done, size: 30, color: Colors.black),
            )
          ],
        ),
        body: Center(
          child: ImgCrop(
            key: cropKey,
            chipRadius: 100,
            chipShape: ChipShape.rect,
            chipRatio: 4/3,
            maximumScale: 5,
            image: FileImage(widget.file),
            // handleSize: 0.0,
          )
        ),
    );
  }
}