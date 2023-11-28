import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:netflix_mobile/adapter/UserAdapter.dart';
import 'package:netflix_mobile/models/user_model.dart';
import 'package:path_provider/path_provider.dart';

class CurrentUser {
  static final CurrentUser _singleton = CurrentUser._internal();
  late Box<Person> _instance;

  factory CurrentUser() {
    return _singleton;
  }

  CurrentUser._internal();

  Future<void> initHive() async {
    var path = "/assets/db";
    if (!kIsWeb) {
      var appDocDir = await getApplicationDocumentsDirectory();
      path = appDocDir.path;
    }
    Hive
      ..init(path)
      ..registerAdapter(PersonAdapter());
    _instance = await Hive.openBox<Person>('userInstance');
  }

  Box<Person> get getInstance {
    return _instance;
  }
}
