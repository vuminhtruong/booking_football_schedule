import 'dart:io';

import 'package:booking_football_schedule/widget/background_image.dart';
import 'package:booking_football_schedule/widget/user_image.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widget/custom_button.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key, required this.phone});

  final String phone;

  @override
  State<UserInfoScreen> createState() {
    return _UserInfoScreenState();
  }
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

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
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: UserImage(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          textField(
                              hintText: null,
                              icon: Icons.phone,
                              inputType: TextInputType.phone,
                              maxLines: 1,
                              controller: phoneController,
                              enable: false,
                              initialValue: null,
                          ),
                          textField(
                            hintText: "Nhập đầy đủ họ và tên",
                            icon: Icons.account_circle,
                            inputType: TextInputType.name,
                            maxLines: 1,
                            controller: fullNameController,
                            enable: true,
                            initialValue: null,
                          ),
                          textField(
                            hintText: "Nhập mật khẩu",
                            icon: Icons.password,
                            inputType: TextInputType.text,
                            maxLines: 1,
                            controller: passwordController,
                            enable: true,
                            initialValue: null,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: CustomButton(
                              text: "Đăng ký",
                              onPressed: () {},
                            ),
                          )
                        ],
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
