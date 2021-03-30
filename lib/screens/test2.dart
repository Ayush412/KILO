import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:camera_image_converter/camera_image_converter.dart';

class Test2 extends StatefulWidget {
  List<CameraDescription> cameras;
  Test2({this.cameras});
  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {

  CameraController controller;
  bool isDetecting = false;

  Interpreter interpreter;
  List<int> inputShape;
  List<int> outputShape;
  TfLiteType outputType = TfLiteType.uint8;
  TensorImage inputImage;
  TensorBuffer outputBuffer;

  loadModel() async{
    try {
      this.interpreter = await Interpreter.fromAsset('models/model.tflite');
      inputShape = interpreter.getInputTensor(0).shape;
      outputShape = interpreter.getOutputTensor(0).shape;
      outputType = interpreter.getOutputTensor(0).type;
      print('In shape: $inputShape');
      outputBuffer = TensorBuffer.createFixedSize(outputShape, outputType);
    } catch (e) {print(e);}
  }

  predictImage(var image) async{
    //read the image as bytes for TensorImage
    img.Image imageInput = img.decodeImage(image.readAsBytesSync());
    //this will be the tensor that will be used for prediction
    inputImage = TensorImage.fromImage(imageInput);
    inputImage = preProcess();
    interpreter.run(inputImage.buffer, outputBuffer.getBuffer());
    print('output buffer shape and type');
    print(outputBuffer.getShape());
    print(outputBuffer.getDataType());
    List<String> labels = await FileUtil.loadLabels('assets/models/dict.txt');
    TensorLabel tensorLabel = TensorLabel.fromList(labels, outputBuffer);
    Map<String, double> doubleMap = tensorLabel.getMapWithFloatValue();
    print('predictions:\n$doubleMap');
  }

  Future<img.Image> _convertYUV420(CameraImage image) async{
  var conv = img.Image(image.width, image.height); // Create Image buffer

  Plane plane = image.planes[0];
  const int shift = (0xFF << 24);

  // Fill image buffer with plane[0] from YUV420_888
  for (int x = 0; x < image.width; x++) {
    for (int planeOffset = 0;
        planeOffset < image.height * image.width;
        planeOffset += image.width) {
      final pixelColor = plane.bytes[planeOffset + x];
      // color: 0x FF  FF  FF  FF
      //           A   B   G   R
      // Calculate pixel color
      var newVal = shift | (pixelColor << 16) | (pixelColor << 8) | pixelColor;

      conv.data[planeOffset + x] = newVal;
    }
  }
    return conv;
  }

  startcam() async {
    await controller.startImageStream((CameraImage image) async {
      if(!isDetecting){
        isDetecting = true;
        var jpeg = await CameraImageConverter.convertCameraImageTo(image, quality: 70);
        print(jpeg.runtimeType);
        //await predictImage(jpeg);
        isDetecting = false;
      }
    });
  }

  TensorImage preProcess() {
    int cropSize = min(inputImage.height, inputImage.width);
    return ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(
        inputShape[1], inputShape[2], ResizeMethod.NEAREST_NEIGHBOUR))
        .build()
        .process(inputImage);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
    controller = new CameraController(
      widget.cameras[1],
      ResolutionPreset.medium,
    );
    controller.initialize().then((_){
      if (!mounted) {
        return;
      }
      setState(() {});
      startcam();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(controller),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: IconButton(
                icon: Icon(Icons.close, size: 28,),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
}