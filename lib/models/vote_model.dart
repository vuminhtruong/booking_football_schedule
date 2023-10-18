import 'package:booking_football_schedule/models/player_model.dart';

class VoteModel {
  String id;
  PlayerData playerData;
  int vote;


  VoteModel({
    required this.id,
    required this.playerData,
    required this.vote,
  });
}



