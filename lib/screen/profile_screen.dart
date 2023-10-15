import 'package:booking_football_schedule/main.dart';
import 'package:booking_football_schedule/screen/welcome_screen.dart';
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
    return Center(
      child: ElevatedButton.icon(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();

            if(!mounted) {
              return;
            }

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const App()));
          },
          icon: const Icon(Icons.logout),
          label: const Text('Đăng xuất')),
    );
  }
}
