import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class NewsData {
  String? id;
  String? title;
  String? content;
  String? idMatch;
  String? urlToImage;
  Timestamp? date;

  NewsData(
      String? id,
      this.title,
      this.idMatch,
      this.content,
      this.date,
      this.urlToImage,
  ) : id = id ?? const Uuid().v4();
}
