import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

// Future<File?> pickImage(BuildContext context) async {
//   File? image;
//
//   try {
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if(pickedImage != null) {
//       image = File(pickedImage.path);
//     }
//   } catch (e) {
//     if(!context.mounted) {
//       return null;
//     }
//     showSnackBar(context, e.toString());
//   }
//
//   return image;
// }

Widget textField({
  required String? hintText,
  required IconData icon,
  required TextInputType inputType,
  required int maxLines,
  required TextEditingController? controller,
  required bool enable,
  required String? initialValue,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: TextFormField(
      initialValue: initialValue,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      decoration: InputDecoration(
        enabled: enable,
        prefixIcon: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black,
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: hintText,
        alignLabelWithHint: true,
        // border: InputBorder.none,
        fillColor: Colors.white60,
        filled: true,
      ),
    ),
  );
}
