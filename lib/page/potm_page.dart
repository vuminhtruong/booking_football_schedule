import 'package:booking_football_schedule/page/result_page.dart';
import 'package:booking_football_schedule/page/vote_page.dart';
import 'package:flutter/material.dart';

class PotmPage extends StatelessWidget {
  const PotmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int day = DateTime.now().day;

    Widget activeWidget;

    Widget lockWidget = const Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quá trình bình chọn đã kết thúc để tiến hành xử lý kết quả.Kết quả sẽ được công bố vào ngày đầu tiên của tháng sau',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          Icon(
            Icons.lock,
            size: 32,
          ),
        ],
      ),
    );

    if (day < 28) {
      activeWidget = const ResultPage();
    } else if (day > 27 && day < 30) {
      activeWidget = const VotePage();
    } else {
      activeWidget = lockWidget;
    }

    return Scaffold(
      body: activeWidget,
    );
  }
}
