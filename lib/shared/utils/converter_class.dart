import 'dart:io';
import 'dart:typed_data';

// this method is used to get the images in formate of bytes to store in sqflite database
Future<Uint8List> imageToBytes(String imagePath) async {
  File file = File(imagePath);
  return await file.readAsBytes();
}
