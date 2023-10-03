import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

class BackgroundImage extends StatefulWidget {
  const BackgroundImage({super.key});

  @override
  State<BackgroundImage> createState() {
    return _BackgroundImageState();
  }
}

class _BackgroundImageState extends State<BackgroundImage> {
  var currentNumber = Random().nextInt(10) + 1;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentNumber = Random().nextInt(10) + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/image$currentNumber.jpg'),
        fit: BoxFit.cover,
        )
      ),
    );
  }

}