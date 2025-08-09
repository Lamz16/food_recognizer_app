import 'package:flutter/material.dart';

class BottomSheetChoiceImage extends StatelessWidget {
  const BottomSheetChoiceImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Panggil fungsi ambil gambar dari galeri
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Panggil fungsi ambil gambar dari kamera
            },
          ),
        ],
      ),
    );
  }
}
