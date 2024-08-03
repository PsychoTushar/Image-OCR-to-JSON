import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'binding/image_picking_binding.dart';
import 'view/image_picker_view.dart';

void main() {
  runApp(const TextExtractorApp());
}

class TextExtractorApp extends StatelessWidget {
  const TextExtractorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      initialBinding: ImagePickerBinding(),
      home: const ImagePickerView(),
    );
  }
}
