import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../helper/news_helper.dart';
import '../models/news_model.dart';
import 'main_news_card.dart';
import 'news_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  var _isLoading = false;

  final NewsHelper newsHelper = NewsHelper();
  List<NewsData> mainNewsList = [];
  List<NewsData> sideNewsList = [];

  @override
  void initState() {
    super.initState();
    loadNewsData();
  }

  Future<void> loadNewsData() async {
    _isLoading = true;
    List<NewsData> fetchedMainNewsList =
        await newsHelper.getNewsDataList('main_news');
    List<NewsData> fetchedSideNewsList =
        await newsHelper.getNewsDataList('side_news');

    if (!mounted) {
      return;
    }

    setState(() {
      mainNewsList = fetchedMainNewsList;
      sideNewsList = fetchedSideNewsList;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    itemBuilder: (context, index, id) =>
                        MainNewsCard(mainNewsList[index]),
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      initialPage: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Tin bên lề',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: sideNewsList.map((e) => NewsListTile(e)).toList(),
                  ),
                ],
              ),
            ),
          );
  }
}
