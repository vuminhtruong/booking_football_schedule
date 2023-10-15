import 'package:booking_football_schedule/page/booking_page.dart';
import 'package:booking_football_schedule/page/chat_page.dart';
import 'package:booking_football_schedule/page/home_page.dart';
import 'package:booking_football_schedule/page/player_page.dart';
import 'package:booking_football_schedule/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  final List<String> _textOptions = ['Trang chủ','Đặt lịch','Cầu thủ','Trò chuyện'];
  final List<Widget> _widgetOptions = const [HomePage(),BookingPage(),PlayerPage(),ChatPage()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text(
          _textOptions[_currentPageIndex],
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              )
          )
        ],
      ),
      body: _widgetOptions[_currentPageIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 4),
        child: GNav(
          backgroundColor: Colors.black,
          rippleColor: Colors.grey,
          hoverColor: Colors.black12,
          haptic: true,
          tabBorderRadius: 15,
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 500),
          gap: 4,
          color: Colors.grey[800],
          activeColor: Colors.deepOrange,
          iconSize: 28,
          tabBackgroundColor: Colors.purple.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          tabs: [
            GButton(
              icon: Icons.home,
              text: _textOptions[0],
            ),
            GButton(
              icon: Icons.calendar_month,
              text: _textOptions[1],
            ),
            GButton(
              icon: Icons.sports_soccer,
              text: _textOptions[2],
            ),
            GButton(
              icon: Icons.chat,
              text: _textOptions[3],
            )
          ],
          selectedIndex: _currentPageIndex,
          onTabChange: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
      ),
    ), onWillPop: () async {
      // Xử lý khi người dùng ấn nút "Back" ở đây
      return false; // Ngăn người dùng quay lại màn hình trước đó
    });
  }
}
