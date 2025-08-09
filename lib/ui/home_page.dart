import 'dart:io';

import 'package:Food_Recognize/ui/bottom_sheet_choice_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Food Recognizer App'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: _HomeBody(),
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return const BottomSheetChoiceImage();
                  },
                );
              },
              child: Consumer<HomeController>(
                builder: (context, controller, _) {
                  if (controller.selectedImagePath != null) {
                    return Image.file(
                      File(controller.selectedImagePath!),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    );
                  }
                  return const Icon(Icons.image, size: 100);
                },
              ),
            ),
          ),
        ),
        FilledButton.tonal(
          onPressed: () {
            context.read<HomeController>().goToResultPage(context);
          },
          child: const Text("Analyze"),
        ),
      ],
    );
  }
}
