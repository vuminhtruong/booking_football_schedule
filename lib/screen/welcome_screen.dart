import 'package:booking_football_schedule/screen/register_screen.dart';
import 'package:booking_football_schedule/widget/background_image.dart';
import 'package:booking_football_schedule/widget/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() {
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 100,
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                          "Let's get started",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Never a better time than now to start.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: CustomButton(
                            text: 'Bắt Đầu',
                            onPressed: () {
                              // xem người dùng còn đăng nhập hay không
                              // nếu còn chuyển hướng đến màn hình Home
                              // nếu không chuyển đến màn hình đăng nhập
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => const RegisterScreen()));
                            },
                          ),
                        ),
                      ],
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
