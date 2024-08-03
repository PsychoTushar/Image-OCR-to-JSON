import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerController extends GetxController {
  var selectedImage = Rxn<File>();
  var extractedText = RxnString();
  var jsonResult = Rxn<Map<String, dynamic>>();

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
      extractedText.value = null;
      jsonResult.value = null;
      await extractText(selectedImage.value!);
    }
  }

  Future<void> extractText(File image) async {
    final InputImage inputImage = InputImage.fromFile(image);
    final TextRecognizer textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    textRecognizer.close();
    extractedText.value = recognizedText.text;
  }

  void convertToJSON() {
    if (extractedText.value != null) {
      jsonResult.value = {'extracted_text': extractedText.value};
    }
  }

  Future<void> saveJsonToFile() async {
    try {
      if (jsonResult.value != null) {
        final status = await Permission.storage.request();
        if (status.isGranted) {
          final directory = Directory("/storage/emulated/0/Download");
          final filePath = '${directory.path}/extracted_text.json';
          final file = File(filePath);
          await file.writeAsString(jsonEncode(jsonResult.value));
          Get.snackbar('Success', 'Json File downloaded successfully');
          print('JSON saved to $filePath');
        } else {
          Get.snackbar(
            'Error',
            'Permission denied to access storage',
            backgroundColor: Colors.red,
          );
        }
      }
    } catch (e) {
      print('Error');
    }
  }

  void showBottomSheetWidget() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.purple),
              title: const Text('Gallery'),
              onTap: () {
                Get.back(); // Close the bottom sheet
                // Handle gallery action
                pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.purple),
              title: const Text('Camera'),
              onTap: () {
                Get.back(); // Close the bottom sheet
                // Handle camera action
                pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }
}
