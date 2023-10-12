import 'package:cloud_firestore/cloud_firestore.dart';

class MatchData {
  String idMatch;
  String? team1;
  String? team2;
  Timestamp time;
  bool isInternal;

  MatchData({
    required this.idMatch,
    required this.team1,
    required this.team2,
    required this.time,
    required this.isInternal,
  });
}