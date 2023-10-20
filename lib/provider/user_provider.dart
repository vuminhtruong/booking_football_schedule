import 'package:booking_football_schedule/helper/user_helper.dart';
import 'package:booking_football_schedule/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier()
      : super(UserModel(null,null,
            name: 'Loading...',
            image:
                'https://firebasestorage.googleapis.com/v0/b/main-app-e9209.appspot.com/o/icon%2Fprofile.png?alt=media&token=6c757f34-37d3-4ed6-ab7d-e728822c9021&_gl=1*24xx8f*_ga*MTgxNTMzMDk5My4xNjk1NTI1OTky*_ga_CW55HF8NVT*MTY5NzYxOTM1MC43NC4xLjE2OTc2MjEwMjguNDguMC4w',
            phone: 'Loading...'));

  final UserHelper userHelper = UserHelper();

  void loadUser() async {
    state = await userHelper.getUserData();
  }

  void updateUser(String birthday,String address) {
    userHelper.updateUser(birthday, address);
  }

  void updateImage(String url) {
    userHelper.updateImageUser(url);
  }

}

final userProvider =
    StateNotifierProvider<UserNotifier, UserModel>((ref) => UserNotifier());
