import 'package:booking_football_schedule/models/player_model.dart';
import 'package:booking_football_schedule/screen/player_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() {
    return _PlayerPageState();
  }
}

class _PlayerPageState extends State<PlayerPage> {
  int selectedButtonIndex = 0;
  String selectedField = 'goal';
  List<String> listField = ['goal', 'assist', 'tackle', 'save'];
  List<String> images = ['ball', 'football-shoes', 'defence', 'goalie'];

  void selectButton(int index) async {
    setState(() {
      selectedButtonIndex = index;
      selectedField = listField[index];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  selectButton(0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedButtonIndex == 0 ? Colors.blue : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Bàn thắng'),
              ),
              ElevatedButton(
                onPressed: () {
                  selectButton(1);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedButtonIndex == 1 ? Colors.blue : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Kiến tạo'),
              ),
              ElevatedButton(
                onPressed: () {
                  selectButton(2);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedButtonIndex == 2 ? Colors.blue : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Đánh chặn'),
              ),
              ElevatedButton(
                onPressed: () {
                  selectButton(3);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedButtonIndex == 3 ? Colors.blue : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Cứu thua'),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: StreamBuilder(
                stream: selectedButtonIndex != 3
                    ? FirebaseFirestore.instance
                        .collection('players')
                        .orderBy(selectedField, descending: false)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('players')
                        .where('position', arrayContains: 'Thủ môn')
                        .orderBy(selectedField, descending: false)
                        .snapshots(),
                builder: (ctx, playersSnapshots) {
                  if (playersSnapshots.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!playersSnapshots.hasData ||
                      playersSnapshots.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('Không có dữ liệu cầu thủ'),
                    );
                  }

                  if (playersSnapshots.hasError) {
                    return const Center(
                      child: Text(
                          'Có lỗi xảy ra trong quá trình lấy dữ liệu.Vui lòng thử lại sau'),
                    );
                  }

                  List<PlayerData> playerDataList =
                      playersSnapshots.data!.docs.map((snapshot) {
                    Map<String, dynamic> data = snapshot.data();
                    String name = data['name'];
                    List<String> position = List<String>.from(data['position']);
                    List<String> team = List<String>.from(data['team']);
                    String image = data['image'];
                    int age = data['age'];
                    int match = data['match'];
                    int goal = data['goal'];
                    int assist = data['assist'];
                    int tackle = data['tackle'];
                    int save = data['save'];

                    return PlayerData(
                      name: name,
                      position: position,
                      team: team,
                      image: image,
                      age: age,
                      match: match,
                      goal: goal,
                      assist: assist,
                      tackle: tackle,
                      save: save,
                    );
                  }).toList();

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: playerDataList.length,
                    itemBuilder: (ctx, index) {
                      int target;
                      switch (selectedButtonIndex) {
                        case 0:
                          target = playerDataList[index].goal;
                          break;
                        case 1:
                          target = playerDataList[index].assist;
                          break;
                        case 2:
                          target = playerDataList[index].tackle;
                          break;
                        default:
                          target = playerDataList[index].save;
                          break;
                      }
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 6,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PlayerDetailScreen(
                                    playerData: playerDataList[index])));
                          },
                          leading: playerDataList[index].image != null
                              ? ClipOval(
                                  child: Image.network(
                                  playerDataList[index].image!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ))
                              : ClipOval(
                                  child: Image.asset(
                                  'assets/images/profile.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )),
                          title: Text(
                            playerDataList[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Vị trí: ${playerDataList[index].position[0]}'),
                              Text(
                                  'Đội bóng: ${playerDataList[index].team[0]}'),
                            ],
                          ),
                          trailing: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(target.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                const SizedBox(width: 6),
                                Image.asset(
                                  'assets/images/${images[selectedButtonIndex]}.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
