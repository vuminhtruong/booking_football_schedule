import 'package:booking_football_schedule/screen/user_info_screen.dart';
import 'package:booking_football_schedule/widget/background_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../utils/utils.dart';
import '../widget/custom_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {super.key, required this.phone, required this.verificationId});

  final String phone;
  final String verificationId;

  @override
  State<OtpScreen> createState() {
    return _OtpScreenState();
  }
}

class _OtpScreenState extends State<OtpScreen> {
  var isLoading = false;
  String? otpCode;
  FirebaseAuth auth = FirebaseAuth.instance;

  void verifyOtp(String verificationId, String userOtp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await auth.signInWithCredential(credential)).user;

      if(user != null) {
        if(!context.mounted) {
          return;
        }
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => UserInfoScreen(phone: widget.phone)));
      }
    } on FirebaseAuthException catch (e) {
      if(!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      if(e.code == 'invalid-verification-code') {
        showSnackBar(context, 'Mã OTP không đúng,vui lòng thử lại');
      } else if(e.code == 'invalid-credential') {
        showAlertDialog(context, 'Thời gian xác thực đã hết,vui lòng thử lại sau');
      }
      else {
        showSnackBar(context, 'Lỗi trong quá trình gửi mã OTP.Vui lòng thử lại sau');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void _login() {
    if(otpCode != null) {
      setState(() {
        isLoading = true;
      });
      verifyOtp(widget.verificationId, otpCode!);
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      showSnackBar(context, "Mã OTP không hợp lệ");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 25, horizontal: 30),
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Xác thực",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Nhập 6 số OTP vừa gửi về máy của bạn",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Pinput(
                      length: 6,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade100,
                          ),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      onCompleted: (value) {
                        setState(() {
                          otpCode = value;
                        });
                      },
                    ),
                    const SizedBox(height: 25),
                    isLoading ? const CircularProgressIndicator() : SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50,
                      child: CustomButton(
                        text: "Gửi",
                        onPressed: _login,
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