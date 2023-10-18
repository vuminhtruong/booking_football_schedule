import 'package:cloud_firestore/cloud_firestore.dart';

class UserVotedHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getUserVotedDataList(int month) async {
    List<String> user_voted = [];
    try {
      DocumentSnapshot doc =
      await _firestore.collection('user_voted').doc('list_$month').get();

      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        user_voted = List<String>.from(data['list_user']);
      } else {
        print('Document danh sách người dùng đã vote không tồn tại');
      }
    } catch (e) {
      print('Lỗi trong quá trình lấy dữ liệu của user_voted: $e');
    }

    return user_voted;
  }

  void updateUserVotedDataList(int month,String uidUser) async {
    try {
     await _firestore.collection('user_voted').doc('list_$month').update({
       'list_user' : FieldValue.arrayUnion([uidUser]),
     });
    } catch (e) {
      print('Lỗi trong quá trình cập nhật dữ liệu user_voted: $e');
    }
  }


}
