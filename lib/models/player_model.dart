class PlayerData {
  String name;
  List<String> position;
  List<String> team;
  String? image;
  int age;
  int match;
  int goal;
  int assist;
  int tackle;
  int save;

  PlayerData({
    required this.name,
    required this.position,
    required this.team,
    required this.image,
    required this.age,
    required this.match,
    required this.goal,
    required this.assist,
    required this.tackle,
    required this.save,
  });
}