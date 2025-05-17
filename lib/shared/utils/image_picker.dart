import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog extends StatefulWidget {
  final Function(ImageSource source) onImagePicked;

  const ImagePickerDialog({super.key, required this.onImagePicked});

  @override
  State<ImagePickerDialog> createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Camera'),
          onTap: () {
            Navigator.of(context).pop();
            widget.onImagePicked(ImageSource.camera);
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Gallery'),
          onTap: () {
            Navigator.of(context).pop();
            widget.onImagePicked(ImageSource.gallery); // Pick from Gallery
          },
        ),
      ],
    );
  }
}
