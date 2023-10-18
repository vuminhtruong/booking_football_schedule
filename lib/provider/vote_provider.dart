import 'package:booking_football_schedule/helper/vote_helper.dart';
import 'package:booking_football_schedule/models/vote_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoteNotifier extends StateNotifier<List<VoteModel>> {
  VoteNotifier() : super(const []);

  Future<void> loadVote() async {
    final VoteHelper voteHelper = VoteHelper();

    List<VoteModel> fetchedVoteList = await voteHelper.getVotesDataList();
    state = fetchedVoteList;
  }
}

final voteProvider = StateNotifierProvider<VoteNotifier,List<VoteModel>>((ref) => VoteNotifier());