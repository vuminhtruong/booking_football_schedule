import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:booking_football_schedule/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<List<Color>> listColors = [
  [
    const Color.fromARGB(255, 77, 160, 176),
    const Color.fromARGB(255, 211, 157, 56)
  ],
  [
    const Color.fromARGB(255, 142, 14, 0),
    const Color.fromARGB(255, 124, 114, 103)
  ],
  [
    const Color.fromARGB(255, 204, 204, 178),
    const Color.fromARGB(255, 117, 117, 25)
  ],
  [
    const Color.fromARGB(255, 234, 205, 163),
    const Color.fromARGB(215, 82, 47, 6)
  ],
  [
    const Color.fromARGB(255, 192, 36, 37),
    const Color.fromARGB(255, 240, 203, 53)
  ],
  [
    const Color.fromARGB(255, 194, 229, 156),
    const Color.fromARGB(255, 100, 179, 244)
  ],
];

class PlayerDetailScreen extends StatelessWidget {
  final PlayerData playerData;

  const PlayerDetailScreen({super.key, required this.playerData});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    int randomNumber = random.nextInt(6);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.orange.shade900),
        title: const Text(
          'Cầu thủ',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: listColors[randomNumber], // Màu sắc gradient
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AvatarGlow(
                    glowColor: Colors.blue,
                    endRadius: 120.0,
                    duration: const Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    child: Material(
                      elevation: 8.0,
                      shape: const CircleBorder(),
                      child: CircleAvatar(
                        radius: 100.0,
                        backgroundImage: NetworkImage(playerData.image!),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              DefaultTextStyle(
                style: GoogleFonts.tiltNeon(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 131, 77, 155),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(playerData.name),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                thickness: 2,
                indent: 40,
                endIndent: 40,
                color: Colors.amber,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Tuổi: ${playerData.age}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'CLB: ${playerData.team.join(', ')}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Vị trí: ${playerData.position.join(', ')}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                thickness: 2,
                indent: 40,
                endIndent: 40,
                color: Colors.amber,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Số trận: ${playerData.match}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Bàn thắng: ${playerData.goal}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Kiến tạo: ${playerData.assist}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Đánh chặn: ${playerData.tackle}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Cản phá: ${playerData.save}',
                style: const TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
