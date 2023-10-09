import 'dart:io';

import 'package:booking_football_schedule/screen/main_screen.dart';
import 'package:booking_football_schedule/widget/background_image.dart';
import 'package:booking_football_schedule/widget/user_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widget/custom_button.dart';

final _firebaseAuth = FirebaseAuth.instance;

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key, required this.phone});

  final String phone;

  @override
  State<UserInfoScreen> createState() {
    return _UserInfoScreenState();
  }
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  File? _selectedImage;
  var _isLoading = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || _selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      showSnackBar(context, 'Ảnh chưa được chọn,vui lòng thêm ảnh');
      return;
    }

    _formKey.currentState!.save();

    try {
      setState(() {
        _isLoading = true;
      });
      final userCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: '${phoneController.text}@football.com',
              password: passwordController.text);

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userCredentials.user!.uid}.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set({
        'phone': phoneController.text,
        'fullName': fullNameController.text,
        'image_url': imageUrl,
      });
      if (!context.mounted) {
        return;
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const MainScreen()));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        showAlertDialog(
            context, 'Số điện thoại đã được sử dụng.Vui lòng sử dụng số khác');
      } else {
        showAlertDialog(context,
            'Lỗi trong quá trình đăng ký thông tin người dùng.Vui lòng thử lại sau');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      phoneController.text = widget.phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const BackgroundImage(),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: UserImage(
                        onPickImage: (pickedImage) {
                          _selectedImage = pickedImage;
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      margin: const EdgeInsets.only(top: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            textField(
                              hintText: null,
                              icon: Icons.phone,
                              inputType: TextInputType.phone,
                              maxLines: 1,
                              controller: phoneController,
                              enable: false,
                              obscureText: false,
                              validator: null,
                              initialValue: null,
                            ),
                            textField(
                              hintText: "Vu Truong",
                              icon: Icons.account_circle,
                              inputType: TextInputType.name,
                              obscureText: false,
                              maxLines: 1,
                              controller: fullNameController,
                              enable: true,
                              validator: (value) {
                                RegExp regex =
                                    RegExp(r'^[A-Za-z]+\s[A-Za-z]+$');
                                if (value == null || value.trim().isEmpty) {
                                  return 'Vui lòng nhập tên của bạn';
                                } else if (!regex.hasMatch(value)) {
                                  return 'Tên không hợp lệ';
                                }
                                return null;
                              },
                              initialValue: null,
                            ),
                            textField(
                              hintText: "6 chữ số(123456)",
                              icon: Icons.password,
                              obscureText: true,
                              inputType: TextInputType.number,
                              maxLines: 1,
                              validator: (value) {
                                RegExp regex = RegExp(r'^\d{6}$');
                                if (value == null || value.trim().isEmpty) {
                                  return 'Vui lòng nhập mật khẩu';
                                } else if (!regex.hasMatch(value)) {
                                  return 'Mật khẩu phải bao gồm 6 chữ số';
                                }
                                return null;
                              },
                              controller: passwordController,
                              enable: true,
                              initialValue: null,
                            ),
                            const SizedBox(height: 20),
                            _isLoading
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    child: CustomButton(
                                      text: "Đăng ký",
                                      onPressed: _submit,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
