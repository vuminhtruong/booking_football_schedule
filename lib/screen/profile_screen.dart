import 'package:booking_football_schedule/main.dart';
import 'package:booking_football_schedule/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../provider/user_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  late String userImage;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dateController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(userProvider.notifier).loadUser();
    final user = ref.watch(userProvider);
    userImage = user.image;

    if (user.birthday != null) {
      _dateController.text = user.birthday!;
    }

    if (user.address != null) {
      _addressController.text = user.address!;
    }

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
                  // SizedBox(
                  //   width: 180,
                  //   height: 180,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(180),
                  //     child: Image.network(user.image),
                  //   ),
                  // ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.image),
                    radius: 110,
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () async {
                        final pickedImage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (pickedImage == null) {
                          return;
                        }

                        final storageRef = FirebaseStorage.instance
                            .ref()
                            .child('user_images')
                            .child(
                                '${FirebaseAuth.instance.currentUser!.uid}.jpg');
                        await storageRef.putFile(File(pickedImage.path));
                        final imageUrl = await storageRef.getDownloadURL();

                        ref.read(userProvider.notifier).updateImage(imageUrl);

                        setState(() {
                          userImage = imageUrl;
                        });
                      },
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
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    initialValue: user.name,
                    enabled: false,
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
                    initialValue: user.phone,
                    enabled: false,
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
                    controller: _dateController,
                    enabled: user.birthday == null,
                    keyboardType: TextInputType.none,
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(1999, 05, 31),
                          firstDate: DateTime(1970, 01, 01),
                          lastDate: DateTime(2015, 12, 31));

                      if (newDate == null) {
                        return;
                      }
                      setState(() {
                        _dateController.text = newDate.toString().split(" ")[0];
                      });
                    },
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
                    controller: _addressController,
                    enabled: user.address == null,
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
                  if(user.birthday == null || user.address == null)
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(userProvider.notifier).updateUser(
                            _dateController.text, _addressController.text);
                        Navigator.of(context).pop();
                      },
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
                    height: 10,
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
                  ),
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
