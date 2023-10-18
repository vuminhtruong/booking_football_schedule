import 'package:booking_football_schedule/helper/user_voted_helper.dart';
import 'package:booking_football_schedule/helper/vote_helper.dart';
import 'package:booking_football_schedule/provider/vote_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:booking_football_schedule/utils/flutter_polls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../screen/player_details_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class VotePage extends ConsumerStatefulWidget {
  const VotePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VotePageState();
  }
}

class _VotePageState extends ConsumerState<VotePage> {
  final String uidUser = _auth.currentUser!.uid;
  late Future<void> _voteFuture;
  int day = 30 - DateTime.now().day;
  int month = DateTime.now().month - 1;
  final UserVotedHelper userVotedHelper = UserVotedHelper();
  final VoteHelper voteHelper = VoteHelper();
  List<String> userVotedList = [];

  @override
  void initState() {
    super.initState();
    _voteFuture = ref.read(voteProvider.notifier).loadVote();
    loadUserVotedList();
  }

  Future<void> loadUserVotedList() async {
    List<String> dataList = await userVotedHelper.getUserVotedDataList(month);
    userVotedList = dataList;

    // setState(() {
    //   userVotedList = dataList;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final voteList = ref.watch(voteProvider);

    return FutureBuilder(
        future: _voteFuture,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: FlutterPolls(
                          pollId: const Uuid().v4(),
                          // hasVoted: hasVoted.value,
                          // userVotedOptionId: userVotedOptionId.value,
                          onVoted:
                              (PollOption pollOption, int newTotalVotes) async {
                            // loadUserVotedList();

                            await Future.delayed(const Duration(seconds: 1));
                            if (userVotedList.contains(uidUser)) {
                              if (!mounted) {
                                return false;
                              }
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Bạn đã bình chọn rồi'),
                                  content: const Text(
                                      'Không thể bình chọn cầu thủ xuất sắc nhất tháng do tài khoản đã bình chọn trước đó'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              voteHelper
                                  .updateVoteData(int.parse(pollOption.id!));
                              userVotedHelper.updateUserVotedDataList(
                                  month, uidUser);
                              return true;
                            }

                            /// If HTTP status is success, return true else false
                            return false;
                          },
                          pollEnded: day < 1,
                          pollTitle: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Theo bạn,cầu thủ nào xứng đáng được vinh danh là cầu thủ xuất sắc nhất tháng này?',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          pollOptions: List<PollOption>.from(
                            voteList.map(
                              (option) {
                                var a = PollOption(
                                  id: option.id,
                                  title: Text(
                                    option.playerData.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  votes: option.vote,
                                );
                                return a;
                              },
                            ),
                          ),
                          votedPercentageTextStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          metaWidget: Text(
                            "Kết thúc trong $day ngày nữa",
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      color: Colors.brown,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Thông tin cầu thủ',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: voteList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => PlayerDetailScreen(
                                        playerData:
                                            voteList[index].playerData)));
                              },
                              leading: voteList[index].playerData.image != null
                                  ? ClipOval(
                                      child: Image.network(
                                      voteList[index].playerData.image!,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ))
                                  : ClipOval(
                                      child: Image.asset(
                                      'assets/images/profile.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    )),
                              title: Text(voteList[index].playerData.name),
                              trailing: const Icon(Icons.more_vert),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Lưu ý: Mỗi tài khoản chỉ được bầu chọn 1 lần,việc xác định cầu thủ xuất sắc nhất tháng phụ thuộc chủ yếu vào đánh giá của các Bình Luận Viên và Trọng Tài,phiếu bầu của người dùng sẽ là 1 phần trong tiêu chí đánh giá cầu thủ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                )),
              ));
  }
}
