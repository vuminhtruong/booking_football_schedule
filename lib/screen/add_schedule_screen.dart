import 'package:booking_football_schedule/utils/utils.dart';
import 'package:booking_football_schedule/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../widget/input_field.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key, required this.date, required this.time});

  final DateTime date;
  final String time;

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
              InputField(
                title: 'Số điện thoại',
                initialValue: phone,
                enabled: false,
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
                if(!isAgreed) {
                  showSnackBar(context, 'Vui lòng xác nhận thông tin chính xác');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
