import 'package:flutter/material.dart';
import 'package:netflix_mobile/data/api.dart';
import 'package:netflix_mobile/models/user_singleton.dart';
import 'package:netflix_mobile/screens/login_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      int id = CurrentUser().getInstance.get('user')!.id;
                      API.changeSession(id, false);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Center(child: Text("Đăng xuất")),
                  ),
                )
              ]),
        ],
      ),
    );
  }
}
