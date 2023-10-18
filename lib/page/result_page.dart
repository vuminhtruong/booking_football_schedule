import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:booking_football_schedule/provider/potm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends ConsumerStatefulWidget {
  const ResultPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _POTMPageState();
  }
}

class _POTMPageState extends ConsumerState<ResultPage> {
  int month = DateTime.now().month != 1 ? DateTime.now().month - 1 : 12;
  late Future<void> _potmFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _potmFuture = ref.read(potmProvider.notifier).loadPOTM(month);
  }

  @override
  Widget build(BuildContext context) {
    final potmData = ref.watch(potmProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child:
        FutureBuilder(
          future: _potmFuture,
          builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator(),)
              :
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Cầu thủ xuất sắc nhất tháng $month',
                        style: GoogleFonts.oswald(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ))),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Hero(
                  tag: "${potmData.image}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(
                      potmData.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/golden-ball.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    AnimatedTextKit(
                      totalRepeatCount: 6,
                      animatedTexts: [
                        ColorizeAnimatedText(
                          potmData.name,
                          textStyle: GoogleFonts.oswald(
                              textStyle: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold)),
                          colors: [
                            Colors.amber,
                            Colors.blue,
                            Colors.pink,
                            Colors.purple,
                          ],
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Image.asset(
                      'assets/images/golden-ball.png',
                      width: 40,
                      height: 40,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/position.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('Vị trí: ${potmData.position!.join(', ')}'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/club.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('Đội bóng: ${potmData.team!.join(', ')}'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontFamily: 'Agne',
                  ),
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TypewriterAnimatedText(potmData.content,
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
