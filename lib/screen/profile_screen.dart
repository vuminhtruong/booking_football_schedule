import 'package:booking_football_schedule/main.dart';
import 'package:booking_football_schedule/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          'Profile',
          style: subHeadingStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/images/profile.png'),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.amberAccent),
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Colors.black,
                          size: 20,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        label: const Text('Họ và Tên'),
                        prefixIcon: const Icon(Icons.account_box),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        prefixIconColor: Colors.black87,
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black87),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black87),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: const Text('Số điện thoại'),
                        prefixIcon: const Icon(Icons.phone_iphone),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        prefixIconColor: Colors.black87,
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black87),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black87),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: const Text('Ngày tháng năm sinh'),
                        prefixIcon: const Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        prefixIconColor: Colors.black87,
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black87),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black87),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: const Text('Địa chỉ'),
                        prefixIcon: const Icon(Icons.map),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        prefixIconColor: Colors.black87,
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black87),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black87),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        'Lưu thông tin',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();

                      if (!mounted) {
                        return;
                      }

                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => const App()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.deepPurple.withOpacity(0.1),
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Đăng xuất',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: 'Lato'),
                        ),
                      ],
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
    // return Center(
    //   child: ElevatedButton.icon(
    //       onPressed: () async {
    //         await FirebaseAuth.instance.signOut();
    //
    //         if(!mounted) {
    //           return;
    //         }
    //
    //         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const App()));
    //       },
    //       icon: const Icon(Icons.logout),
    //       label: const Text('Đăng xuất')),
    // );
  }
}
