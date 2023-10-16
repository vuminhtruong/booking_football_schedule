import 'package:booking_football_schedule/utils/utils.dart';
import 'package:booking_football_schedule/widget/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({super.key});

  @override
  State<IndividualScreen> createState() {
    return _IndividualScreenState();
  }
}

class _IndividualScreenState extends State<IndividualScreen> {
  late String? message;
  String? _phone;
  var _enteredName = '';
  var _enteredAge = '';
  var _enteredTime = '';
  var _enteredPower = '';
  var _enteredLevel = '';
  final _formKey = GlobalKey<FormState>();

  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    _phone = user.email!.split('@')[0];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Tạo yêu cầu',
                style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Mục này dành cho những cầu thủ muốn thi đấu nhưng chưa có đội bóng để đá,ban quản lý sân sẽ sớm liên hệ với bạn khi có đủ số lượng để ghép đội,tùy thuộc vào trình độ mà bạn cung cấp,vui lòng quay trở lại nếu bạn không có nhu cầu',
                style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                )),
                textAlign: TextAlign.center,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          enabled: _phone == null ? true : false,
                          initialValue: _phone,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Số điện thoại'),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 10) {
                              return 'Vui lòng nhập số điện thoại hợp lệ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _phone = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Họ và Tên'),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 5) {
                              return 'Vui lòng nhập họ và tên hợp lệ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredName = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Tuổi'),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tuổi của bạn';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredAge = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Ví dụ: Mọi ngày từ 17h-21h',
                            label: Text('Thời gian có thể đá được'),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 5) {
                              return 'Vui lòng nhập thời gian hợp lệ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredTime = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:
                                'Ví dụ: Chỉ đá được 5,10,.. phút hoặc cả trận',
                            label: Text('Tình trạng thể lực'),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập lại tình trạng thể lực ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPower = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Tự cảm nhận về trình độ đá bóng',
                            label: Text('Trình độ chuyên môn'),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 5) {
                              return 'Vui lòng nhập lại trình độ chuyên môn';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredLevel = value!;
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: isAgreed,
                              onChanged: (value) {
                                setState(() {
                                  isAgreed = value!;
                                });
                              }),
                          const Text(
                              'Tôi xác nhận thông tin là hoàn toàn chính xác'),
                        ],
                      ),
                      CustomButton(
                          text: "Xác nhận",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              if (!isAgreed) {
                                showSnackBar(context,
                                    'Vui lòng xác nhận thông tin bạn cung cấp là chính xác');
                                return;
                              }

                              try {
                                await FirebaseFirestore.instance
                                    .collection('form_individual')
                                    .doc(user.uid)
                                    .set({
                                  'phone': _phone,
                                  'name': _enteredName,
                                  'age': _enteredAge,
                                  'time': _enteredTime,
                                  'power': _enteredPower,
                                  'level': _enteredLevel,
                                });
                              } catch (e) {
                                message = 'Có lỗi trong quá trình gửi yêu cầu: $e';
                              }

                              _formKey.currentState!.reset();
                              message = 'Gửi yêu cầu thành công,chúng tôi sẽ sớm liên hệ đến bạn';

                              if (!context.mounted) {
                                return;
                              }

                              showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                                title: const Text('Thông báo'),
                                content: Text(message!),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ),);
                            }
                          }),
                    ],
                  )),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
