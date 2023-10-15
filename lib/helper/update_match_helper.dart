import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booking_football_schedule/models/match_model.dart';

class UpdateMatchHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateMatch(String collectionName, String documentName, bool matchEmpty,
      String newValue,String orderer) async {
    late String field;
    String combined = '$newValue($orderer)';
    if (matchEmpty) {
      field = 'team1';
    } else {
      field = 'team2';
    }
    try {
      await _firestore
          .collection(collectionName)
          .doc(documentName)
          .update({
              field: newValue,
              'orderer': FieldValue.arrayUnion([combined]),
          });
    } catch (e) {
      print('Lỗi trong quá trình cập nhật dữ liệu match: $e');
    }
  }
}
