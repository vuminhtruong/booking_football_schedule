import 'package:booking_football_schedule/helper/news_helper.dart';
import 'package:booking_football_schedule/models/news_model.dart';
import 'package:booking_football_schedule/widget/main_news_card.dart';
import 'package:booking_football_schedule/widget/news_list_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsHelper newsHelper = NewsHelper();
  List<NewsData> mainNewsList = [];
  List<NewsData> sideNewsList = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNewsData();
  }

  Future<void> loadNewsData() async {
    List<NewsData> fetchedMainNewsList = await newsHelper.getNewsDataList('main_news');
    List<NewsData> fetchedSideNewsList = await newsHelper.getNewsDataList('side_news');

    if(!mounted) {
      return;
    }

    setState(() {
      mainNewsList = fetchedMainNewsList;
      sideNewsList = fetchedSideNewsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: const Text(
          "Trang chủ",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tin nổi bật",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              CarouselSlider.builder(
                  itemCount: mainNewsList.length,
                  itemBuilder: (context, index, id) => MainNewsCard(mainNewsList[index]),
                  options: CarouselOptions(
                    aspectRatio: 16/9,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    initialPage: 1,
                  ),
              ),
              const SizedBox(height: 40,),
              const Text(
                'Tin bên lề',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16,),
              Column(
                children: sideNewsList.map((e) => NewsListTile(e)).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: BottomNavigationBar(
          elevation: 0.0,
          selectedItemColor: Colors.orange.shade900,
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(Icons.home),
              label: "Trang chủ",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Đặt lịch",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer),
              label: "Thông tin",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Trò chuyện",
            ),
          ],
        ),
      ),
    );
  }
}
