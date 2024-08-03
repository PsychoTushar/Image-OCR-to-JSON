import 'package:conversion/controller/image_picker_controller.dart';
import 'package:conversion/widgets/extracted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerView extends GetView<ImagePickerController> {
  const ImagePickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Image OCR to JSON'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (controller.selectedImage.value == null)
                Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(),
                            color: Colors.grey[300],
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.showBottomSheetWidget();
                            },
                            icon: const Icon(
                              Icons.add_photo_alternate_rounded,
                              size: 50,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Click on the icon to select the image',
                    ),
                  ],
                )
              else
                ExtractedTextWidget(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
