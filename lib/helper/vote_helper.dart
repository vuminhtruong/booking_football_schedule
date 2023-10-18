import 'package:booking_football_schedule/models/player_model.dart';
import 'package:booking_football_schedule/models/vote_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoteHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VoteModel>> getVotesDataList() async {
    List<VoteModel> newsList = [];

    try {
      QuerySnapshot querySnapshot = await _firestore.collection('vote').get();
      for (var element in querySnapshot.docs) {
        PlayerData? player;
        var data = element.data() as Map<String, dynamic>;
        final document = data['player'] as DocumentReference;
        await FirebaseFirestore.instance.doc(document.path).get().then((value) {
          var data = value.data() as Map<String, dynamic>;
          var playerData = PlayerData(
              name: data['name'],
              position: List<String>.from(data['position']),
              team: List<String>.from(data['team']),
              image: data['image'],
              age: data['age'],
              match: data['match'],
              goal: data['goal'],
              assist: data['assist'],
              tackle: data['tackle'],
              save: data['save']);
          player = playerData;
        });

        var voteData =
            VoteModel(id: data['id'], playerData: player!, vote: data['vote']);
        newsList.add(voteData);
      }
    } catch (e) {
      print('Lỗi trong quá trình lấy dữ liệu của vote: $e');
    }

    return newsList;
  }

  void updateVoteData(int id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('vote').doc('vote_$id').get();
      var data = doc.data() as Map<String, dynamic>;
      int vote = data['vote'];
      await _firestore.collection('vote').doc('vote_$id').update({
        'vote': vote + 1,
      });
    } catch (e) {
      print('Lỗi trong quá trình cập nhật dữ liệu vote: $e');
    }
  }
}
