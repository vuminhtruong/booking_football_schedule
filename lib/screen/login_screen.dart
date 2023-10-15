import 'package:booking_football_schedule/screen/main_screen.dart';
import 'package:booking_football_schedule/utils/utils.dart';
import 'package:booking_football_schedule/widget/background_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/custom_button.dart';

final _firebaseAuth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  var _isAuthenticating = false;

  void _login() async {
    setState(() {
      _isAuthenticating = true;
    });

    try {
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: '${phoneController.text}@football.com', password: passwordController.text);
      if(!context.mounted) {
        return;
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const MainScreen()));
    } on FirebaseAuthException catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      if(error.code == 'INVALID_LOGIN_CREDENTIALS') {
        showSnackBar(context, 'Số điện thoại hoặc mật khẩu không đúng,vui lòng thử lại');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? 'Authentication failed.')));
      }
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
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
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Nhập số điện thoại đã được xác minh và mật khẩu",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(11)],
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
                      labelText: 'Số điện thoại',
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
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                    controller: passwordController,
                    onChanged: (value) {
                      setState(() {
                        passwordController.text = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
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
                          Icons.password,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isAuthenticating ? const CircularProgressIndicator() : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      text: "Đăng nhập",
                      onPressed: _login,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Chưa có tài khoản?",
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
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Đăng ký',
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
