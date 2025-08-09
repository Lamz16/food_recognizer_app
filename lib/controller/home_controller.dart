import 'package:flutter/material.dart';

import '../ui/result_page.dart';

class HomeController extends ChangeNotifier {

  String? selectedImagePath;

  void setImage(String path) {
    selectedImagePath = path;
    notifyListeners();
  }

  void goToResultPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultPage()),
    );
  }
}
