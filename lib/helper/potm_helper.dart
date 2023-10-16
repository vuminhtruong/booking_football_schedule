import 'package:booking_football_schedule/models/news_model.dart';
import 'package:booking_football_schedule/models/potm_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PotmHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<PotmModel?> getPotmData(int month) async {
    PotmModel? potmModel;

    try {
      DocumentSnapshot doc =
          await _firestore.collection('potm').doc('month_$month').get();

      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        potmModel = PotmModel(
            name: data['name'],
            position: List<String>.from(data['position']),
            team: List<String>.from(data['team']),
            image: data['image'],
            content: data['content']);
      } else {
        print('Document POTM không tồn tại');
      }
    } catch (e) {
      print('Lỗi trong quá trình lấy dữ liệu của potm: $e');
    }

    return potmModel;
  }
}
