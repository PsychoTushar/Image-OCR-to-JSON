import 'dart:convert';
import 'package:conversion/controller/image_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ExtractedTextWidget extends StatelessWidget {
  const ExtractedTextWidget({
    super.key,
    required this.controller,
  });

  final ImagePickerController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: SizedBox(
          width: Get.width * 0.9,
          child: Card(
            elevation: 5.0,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 16.0),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Image.file(controller.selectedImage.value!)),
                    const SizedBox(height: 20),
                    if (controller.extractedText.value != null)
                      Container(
                        width: Get.width * 9,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // child: Text(controller.extractedText.value!),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Extracted Text from the image\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                  text: controller.extractedText.value!,
                                  style: const TextStyle(color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.convertToJSON,
                      child: const Text('Convert to JSON'),
                    ),
                    if (controller.jsonResult.value != null) ...[
                      const SizedBox(height: 20),
                      Container(
                        width: Get.width * 9,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // child: Text(jsonEncode(controller.jsonResult.value)),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Content of the JSON file \n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                  text: jsonEncode(controller.jsonResult.value),
                                  style: const TextStyle(color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: controller.saveJsonToFile,
                        child: const Text('Download JSON'),
                      ),
                    ],
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () =>
                          // controller.pickImage(ImageSource.gallery),
                          controller.showBottomSheetWidget(),
                      child: const Text('Pick Another Image'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
