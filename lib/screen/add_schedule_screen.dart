import 'package:booking_football_schedule/helper/update_match_helper.dart';
import 'package:booking_football_schedule/utils/utils.dart';
import 'package:booking_football_schedule/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../widget/input_field.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key, required this.date, required this.time, required this.team1});

  final DateTime date;
  final String time;
  final String? team1;

  @override
  State<AddScheduleScreen> createState() {
    return _AddScheduleScreenState();
  }
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  bool isAgreed = false;
  final TextEditingController _teamController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _teamController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    late String? phone;
    final UpdateMatchHelper updateMatchHelper = UpdateMatchHelper();
    final bool matchEmpty = widget.team1!.isEmpty ? true : false;

    for (var userInfo in user.providerData) {
      if (userInfo.providerId == "phone") {
        phone = user.phoneNumber;
      } else if (userInfo.providerId == "password") {
        phone = user.email!.split('@')[0];
      }
    }

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
                'Đặt lịch',
                style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
              ),
              const SizedBox(height: 8,),
              Text(
                'Quý khách lưu ý,vui lòng nhập chính xác tên đội bóng của mình,không nên nhập tên quá dài cũng như quá vắn tắt,đảm bảo thời gian thi đấu chính xác,nếu muốn thay đổi thông tin hay hủy kèo vui lòng liên hệ với quản lý sân vận động',
                style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    )),
                textAlign: TextAlign.center,
              ),
              InputField(
                title: 'Số điện thoại',
                initialValue: phone,
                enabled: phone == null ? true : false,
              ),
              InputField(
                title: 'Tên đội',
                hint: 'Nhập tên đội',
                controller: _teamController,
                enabled: true,
              ),
              InputField(
                title: 'Ngày',
                hint: DateFormat('dd-MM-yyyy').format(widget.date),
                widget: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                enabled: false,
              ),
              InputField(
                title: 'Giờ',
                hint: widget.time,
                widget: const Icon(
                  Icons.access_time_rounded,
                  color: Colors.grey,
                ),
                enabled: false,
              ),
              const SizedBox(height: 12,),
              Row(
                children: [
                Checkbox(value: isAgreed, onChanged: (value) {
                  setState(() {
                    isAgreed = value!;
                  });
                }),
                const Text('Tôi xác nhận thông tin là hoàn toàn chính xác'),
              ],),
              CustomButton(text: "Xác nhận", onPressed: () {
                if(_teamController.text.isEmpty) {
                  showSnackBar(context, 'Vui lòng nhập tên đội bóng');
                } else if(!isAgreed) {
                  showSnackBar(context, 'Vui lòng xác nhận thông tin bạn cung cấp là chính xác');
                } else {
                  updateMatchHelper.updateMatch(
                      DateFormat('yyyy-MM-dd').format(widget.date), widget.time,
                      matchEmpty, _teamController.text);
                  Navigator.of(context).pop();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
