import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:booking_football_schedule/screen/add_schedule_screen.dart';
import 'package:booking_football_schedule/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const colorizeColors1 = [
//   Colors.yellow,
//   Colors.white,
//   Colors.blue,
//   Colors.red,
// ];
//
// const colorizeColors2 = [
//   Colors.deepOrange,
//   Color(0xFF424242),
//   Color(0xFF1B5E20),
//   Colors.blue,
// ];

class MatchCard extends StatelessWidget {
  final String idMatch;
  final String? team1;
  final String? team2;
  final String time;
  final bool isInternal;
  final DateTime date;

  const MatchCard({
    super.key,
    required this.idMatch,
    required this.team1,
    required this.team2,
    required this.time,
    required this.isInternal, required this.date,
  });

  @override
  Widget build(BuildContext context) {
    var stateCard = 0;
    String imagePath = 'assets/images/cup.png';

    if (isInternal) {
      stateCard = 1;
      imagePath = 'assets/images/cup2.png';
    } else {
      if (team1!.isEmpty) {
        stateCard = 2;
      }
      if (team1!.isNotEmpty && team2!.isEmpty) {
        stateCard = 3;
      }
    }
    return InkWell(
        onTap: () {
          if(isInternal || team2!.isNotEmpty) {
            return;
          }
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AddScheduleScreen(date: date,time: time, team1: team1,)));
        },
        child: Container(
          key: ObjectKey(idMatch),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _getBGClr(stateCard),
              ),
            ),
            child: Row(children: [
              Text(
                time,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 0.5,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (team1 != null)
                      Text(
                        team1!,
                        style: subHeadingStyle,
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Icon(
                      Icons.sports_soccer,
                      color: Colors.blueGrey,
                      size: 24,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    team2 != null
                        ? Text(
                            team2!,
                            style: subHeadingStyle,
                          )
                        : const Text(
                            'Nội bộ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 0.5,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              Container(
                width: 30,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  _getBGClr(int no) {
    switch (no) {
      case 1:
        return [
          const Color(0xFF4e5ae8),
          const Color.fromARGB(211, 35, 45, 128)
        ];
      case 2:
        return [
          const Color(0xFFFFB746),
          const Color.fromARGB(212, 95, 103, 10)
        ];
      case 3:
        return [const Color(0xFFff4667), const Color.fromARGB(213, 93, 7, 40)];
      default:
        return [
          const Color(0xFF1B5E20),
          const Color.fromARGB(123, 33, 232, 20)
        ];
    }
  }
}
