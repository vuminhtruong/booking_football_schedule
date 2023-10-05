import 'package:booking_football_schedule/screen/login_screen.dart';
import 'package:booking_football_schedule/screen/otp_screen.dart';
import 'package:booking_football_schedule/utils/utils.dart';
import 'package:booking_football_schedule/widget/background_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      //phoneNumber: phoneNumber,
      phoneNumber: '+1 650-650-1234',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException exception) {
        print('Xảy ra lỗi: ${exception.message}');
      },
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = '';
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (ctx) => OtpScreen(
                      // phone: phoneNumber,
                      phone: '06506501234',
                      verificationId: verificationId,
                    )));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        ScaffoldMessenger.of(context).clearSnackBars();
        showSnackBar(
            context, 'Thời gian xác thực mã OTP đã kết thúc.Vui lòng thử lại');
      },
    );
  }

  void _userLogin() async {
    String phoneNumber = phoneController.text;
    if (phoneNumber.length != 9) {
      ScaffoldMessenger.of(context).clearSnackBars();
      showSnackBar(context, 'Vui lòng nhập số điện thoại hợp lệ');
    } else {
      signInWithPhoneNumber("+84$phoneNumber");
    }
  }

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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Đăng ký tài khoản",
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
                  const SizedBox(height: 10),
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
                      text: "Đăng ký",
                      onPressed: () {
                        //xac thuc otp
                        _userLogin();
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Đã có tài khoản?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const LoginScreen()));
                    },
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ],
    );
  }
}
