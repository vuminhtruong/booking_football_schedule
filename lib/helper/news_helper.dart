import 'package:booking_football_schedule/models/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<NewsData>> getNewsDataList(String nameCollection) async {
    List<NewsData> newsList = [];

    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(nameCollection).get();
      for (var element in querySnapshot.docs) {
        var data = element.data() as Map<String, dynamic>;
        var newsData = NewsData(data['id'], data['title'], data['idMatch'],
            data['content'], data['date'], data['urlToImage']);
        newsList.add(newsData);
      }
    } catch (e) {
      print('Lỗi trong quá trình lấy dữ liệu của news: $e');
    }

    return newsList;
  }
}
