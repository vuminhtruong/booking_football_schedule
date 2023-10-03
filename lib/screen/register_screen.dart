import 'package:booking_football_schedule/widget/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 70),
                    const Text(
                      "Đăng ký",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Thêm số điện thoại của bạn và đợi mã xác nhận gửi về máy",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(9)],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                      controller: phoneController,
                      onChanged: (value) {
                        setState(() {
                          phoneController.text = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        // hintText: "123456789",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.blue[45],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blueAccent),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.phone,
                            color: Colors.blueAccent,
                          ),
                        ),
                        prefixText: '+84',
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomButton(
                        text: "Login",
                        onPressed: () {
                          // xac thuc OTP
                        },
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
