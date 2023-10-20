import 'package:booking_football_schedule/page/booking_page.dart';
import 'package:booking_football_schedule/page/home_page.dart';
import 'package:booking_football_schedule/page/player_page.dart';
import 'package:booking_football_schedule/page/potm_page.dart';
import 'package:booking_football_schedule/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../provider/user_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentPageIndex = 0;
  final List<String> _textOptions = ['Trang chủ','Đặt lịch','Cầu thủ','POTM'];
  final List<Widget> _widgetOptions = const [HomePage(),BookingPage(),PlayerPage(),PotmPage()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(userProvider.notifier).loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

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
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal:12,vertical: 4),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.image),
                  radius: 18,
                ),
              ),
            ),
          ),
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
              icon: Icons.how_to_vote,
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
