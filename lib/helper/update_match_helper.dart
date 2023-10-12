import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booking_football_schedule/models/match_model.dart';

class UpdateMatchHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateMatch(String collectionName, String documentName,
      bool matchEmpty, String newValue) async {
    late String field;
    if (matchEmpty) {
      field = 'team1';
    } else {
      field = 'team2';
    }
    try {
      await _firestore.collection(collectionName).doc(
          documentName).update({field: newValue});
    } catch (e) {
      print('Lỗi trong quá trình cập nhật dữ liệu: $e');
    }
  }

}
