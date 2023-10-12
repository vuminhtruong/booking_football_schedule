import 'package:booking_football_schedule/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void showAlertDialog(BuildContext context,String content) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => const WelcomeScreen()));
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Lỗi"),
    content: Text(content),
    actions: [
      okButton,
    ],
  );
  
  showDialog(context: context, builder: (BuildContext context) {
    return alert;
  });
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    )
  );
}

Widget textField({
  required String? hintText,
  required IconData icon,
  required TextInputType inputType,
  required int maxLines,
  required TextEditingController? controller,
  required bool enable,
  required bool obscureText,
  required String? Function(String?)? validator,
  required String? initialValue,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      enableSuggestions: false,
      autocorrect: false,
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


