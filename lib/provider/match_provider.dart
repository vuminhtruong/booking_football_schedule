import 'package:booking_football_schedule/helper/matches_helper.dart';
import 'package:booking_football_schedule/models/match_model.dart';
import 'package:riverpod/riverpod.dart';

class MatchNotifier extends StateNotifier<List<MatchData>> {
  MatchNotifier() : super(const []);

  Future<void> loadMatches(String date) async {
    final MatchesHelper matchesHelper = MatchesHelper();

    List<MatchData> fetchedMatchesList = await matchesHelper.getNewsDataList(date);
    state = fetchedMatchesList;
  }
}

final matchesProvider = StateNotifierProvider<MatchNotifier,List<MatchData>>((ref) => MatchNotifier());