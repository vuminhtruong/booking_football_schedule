import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  const UserImage({super.key, required this.onPickImage});
  final void Function(File pickedImage) onPickImage;

  @override
  State<StatefulWidget> createState() {
    return _UserImageState();
  }
}

class _UserImageState extends State<UserImage> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
          radius: 65,
          backgroundColor: Colors.white60,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.add_a_photo,color: Colors.white60,),
          label: const Text(
            'Thêm ảnh',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 16
            ),
          ),
        )
      ],
    );
  }
}
