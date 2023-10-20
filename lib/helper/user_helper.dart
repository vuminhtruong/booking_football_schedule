import 'package:booking_football_schedule/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Future<UserModel> getUserData() async {
    late UserModel userModel;
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user!.uid).get();
      if(doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        userModel = UserModel(data['address'],data['birthday'],name: data['fullName'], image: data['image_url'], phone: data['phone']);
      } else {
        print('Document user không tồn tại');
      }
    } catch (e) {
      print('Lỗi trong quá trình lấy dữ liệu của user: $e');
    }
    return userModel;
  }

  void updateUser(String birthday,String address) async {
    try{
      await _firestore.collection('users').doc(user!.uid).update({
        'birthday' : birthday,
        'address' : address,
      });
    } catch(e) {
      print('Lỗi trong quá trình cập nhật dữ liệu user: $e');
    }
  }

  void updateImageUser(String url) async {
    try{
      await _firestore.collection('users').doc(user!.uid).update({
        'image_url' : url,
      });
    } catch(e) {
      print('Lỗi trong quá trình cập nhật dữ liệu user: $e');
    }
  }

}
