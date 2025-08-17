import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class FoodClassifier {
  late Interpreter _interpreter;
  late List<String> _labels;
  final modelPath = 'assets/foodmodel.tflite';
  final labelsPath = 'assets/labels.txt';

  Future<void> loadModel() async {
    final options = InterpreterOptions()
      ..useNnApiForAndroid = true
      ..useMetalDelegateForIOS = true;

    _interpreter = await Interpreter.fromAsset(modelPath, options: options);

    print("Input shape: ${_interpreter.getInputTensor(0).shape}");
    print("Input type: ${_interpreter.getInputTensor(0).type}");
    print("Output shape: ${_interpreter.getOutputTensor(0).shape}");
    print("Output type: ${_interpreter.getOutputTensor(0).type}");

    final labelsData = await rootBundle.loadString(labelsPath);
    _labels = labelsData
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  Future<Map<String, dynamic>> classify(File imageFile) async {
    final rawImage = img.decodeImage(await imageFile.readAsBytes())!;
    final resized = img.copyResize(rawImage, width: 192, height: 192);

    // input [1,192,192,3] dengan uint8
    var input = List.generate(1, (_) {
      return List.generate(192, (y) {
        return List.generate(192, (x) {
          final pixel = resized.getPixel(x, y);
          return [
            pixel.r, // langsung int 0–255
            pixel.g,
            pixel.b,
          ];
        });
      });
    });

    // output [1,2024] (uint8)
    var output = List.generate(1, (_) => List.filled(_labels.length, 0));

    _interpreter.run(input, output);

    int maxIndex = 0;
    int maxScore = output[0][0];
    for (int i = 1; i < _labels.length; i++) {
      if (output[0][i] > maxScore) {
        maxScore = output[0][i];
        maxIndex = i;
      }
    }

    print("Input tensor type: ${_interpreter.getInputTensor(0).type}");
    print("Output tensor type: ${_interpreter.getOutputTensor(0).type}");

    return {
      "label": _labels[maxIndex],
      "confidence": maxScore / 255.0, // normalisasi biar 0–1
    };
  }



}
