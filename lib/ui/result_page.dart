import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/food_classifier.dart';
import '../widget/classification_item.dart';

class ResultPage extends StatelessWidget {
  final String imagePath;
  const ResultPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Result Page'),
      ),
      body: SafeArea(
        child: _ResultBody(imagePath: imagePath),
      ),
    );
  }
}

class _ResultBody extends StatefulWidget {
  final String imagePath;
  const _ResultBody({required this.imagePath});

  @override
  State<_ResultBody> createState() => _ResultBodyState();
}

class _ResultBodyState extends State<_ResultBody> {
  final classifier = FoodClassifier();
  String? _label;
  double? _confidence;

  @override
  void initState() {
    super.initState();
    _analyzeImage();
  }

  Future<void> _analyzeImage() async {
    await classifier.loadModel();
    final result = await classifier.classify(File(widget.imagePath));
    setState(() {
      _label = result["label"];
      _confidence = result["confidence"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: Image.file(
              File(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: _label == null
              ? const Center(child: CircularProgressIndicator())
              : ClassificatioinItem(
            item: _label!,
            value: "${(_confidence! * 100).toStringAsFixed(2)}%",
          ),
        ),
      ],
    );
  }
}

