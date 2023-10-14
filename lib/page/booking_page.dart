import 'package:booking_football_schedule/provider/match_provider.dart';
import 'package:booking_football_schedule/screen/individual_screen.dart';
import 'package:booking_football_schedule/utils/utils.dart';
import 'package:booking_football_schedule/widget/custom_button.dart';
import 'package:booking_football_schedule/widget/match_card.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({super.key});

  @override
  ConsumerState<BookingPage> createState() {
    return _BookingPageState();
  }
}

class _BookingPageState extends ConsumerState<BookingPage> {
  // late Future<void> _matchesFuture;
  DateTime _selectedDate = DateTime.now();

  // @override
  // void initState() {
  //   super.initState();
  //   // _matchesFuture = _loadMatches;
  // }

  Future<void> get _loadMatches async {
    return await ref
        .read(matchesProvider.notifier)
        .loadMatches(DateFormat('yyyy-MM-dd').format(_selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    _loadMatches;
    final matches = ref.watch(matchesProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: subHeadingStyle,
                    ),
                    const Text('Hôm nay'),
                  ],
                ),
                CustomButton(
                  text: '+ Yêu cầu',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const IndividualScreen()));
                  }
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            DatePicker(
              DateTime.now(),
              height: 80,
              width: 60,
              daysCount: 15,
              initialSelectedDate: DateTime.now(),
              selectionColor: const Color(0xFF4e5ae8),
              selectedTextColor: Colors.white,
              dateTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              dayTextStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              monthTextStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: matches
                  .map((match) => MatchCard(
                        idMatch: match.idMatch,
                        team1: match.team1,
                        team2: match.team2,
                        time: DateFormat.Hm().format(match.time.toDate()),
                        isInternal: match.isInternal,
                        date: _selectedDate,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
