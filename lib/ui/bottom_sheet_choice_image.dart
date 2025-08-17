import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/home_controller.dart';

class BottomSheetChoiceImage extends StatelessWidget {
  const BottomSheetChoiceImage({super.key});

  Future<void> _pickFromGallery(BuildContext context) async {
    final homeController = context.read<HomeController>();
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      homeController.setImage(pickedFile.path);
    }
  }

  Future<void> _pickFromCamera(BuildContext context) async {
    final homeController = context.read<HomeController>();
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      homeController.setImage(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Gallery'),
            onTap: () async {
              await _pickFromGallery(context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              await _pickFromCamera(context);
              Navigator.pop(context);
              // TODO: Panggil fungsi ambil gambar dari kamera
            },
          ),
        ],
      ),
    );
  }
}
