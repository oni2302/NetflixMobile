import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:netflix_mobile/models/user_singleton.dart';
import 'package:netflix_mobile/screens/login_screen.dart';
import 'package:netflix_mobile/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CurrentUser().initHive();
  var user = CurrentUser().getInstance;
  if (user.isNotEmpty)
    runApp(MyApp(
      isLoggedIn: true,
    ));
  else
    runApp(MyApp(
      isLoggedIn: false,
    ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (isLoggedIn) ? NavScreen() : LoginScreen(),
    );
  }
}
