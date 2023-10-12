import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booking_football_schedule/models/match_model.dart';

class MatchesHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<MatchData>> getNewsDataList(String date) async {
    List<MatchData> matchesList = [];

    try {
      QuerySnapshot querySnapshot = await _firestore.collection(date).get();
      for (var element in querySnapshot.docs) {
        var data = element.data() as Map<String, dynamic>;
        var matchesData = MatchData(
            idMatch: data['idMatch'],
            team1: data['team1'],
            team2: data['team2'],
            time: data['time'],
            isInternal: data['is_Internal']);
        matchesList.add(matchesData);
      }
    } catch (e) {
      print('Lỗi trong quá trình lấy dữ liệu: $e');
    }

    return matchesList;
  }
}
