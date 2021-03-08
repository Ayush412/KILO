import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  Interpreter interpreter;
  List<int> inputShape;
  List<int> outputShape;
  TfLiteType outputType = TfLiteType.uint8;
  TensorImage inputImage;
  TensorBuffer outputBuffer;

  final picker = ImagePicker();
  getImage() async{
    var file = await picker.getImage(source: ImageSource.gallery);
    if (file == null) return;
    print(file.path);
    await loadModel();
    await predictImage(File(file.path));
  }

  predictImage(File image) async{
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

  TensorImage preProcess() {
    int cropSize = min(inputImage.height, inputImage.width);
    return ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(
        inputShape[1], inputShape[2], ResizeMethod.NEAREST_NEIGHBOUR))
        .build()
        .process(inputImage);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RaisedButton(
          onPressed: () => getImage(),
          child: Text("Image"),
        ),
      ),
    );
  }
}