import 'dart:convert';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netflix_mobile/models/models.dart';
import 'package:netflix_mobile/models/user_model.dart';
import 'package:netflix_mobile/models/user_singleton.dart';

class API {
  static final String ip = "http://192.168.1.203";
  //Fetch JSON data from API;
  static Future<Content> fetchData(String url) async {
    int id = CurrentUser().getInstance.getAt(0)!.id;
    final dio = Dio();
    final response = await dio.get(ip + "/" + url + "?id= ${id}");

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final Map<String, dynamic> data = json.decode(response.data);
      print(data);
      return Content.fromJson(data);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      print('loi');
      throw Exception('Failed to load data');
    }
  }

  //Fetch List JSON data from API
  static Future<List<Content>> fetchListData(String url) async {
    final dio = Dio();
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final List<Map<String, dynamic>> data = json.decode(response.data);

      List<Content> contentList = [];

      for (var item in data) {
        contentList.add(Content.fromJson(item));
      }
      return contentList;
    } else {
      return [];
    }
  }

  //LoadImage
  static Image loadImageUrl(String url) {
    return Image(image: NetworkImage(API.ip + "/API/getImage/?url=" + url));
  }

  static Future<Person> validateLogin(String username, String pass) async {
    FormData formData = FormData.fromMap({
      'username': username,
      'password': pass,
    });
    final dio = Dio();
    final response = await dio.post(ip + "/API/clientLogin/", data: formData);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.data);
      return Person.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static void saveHistory(
      int user, int video, int hour, int minute, int second) async {
    FormData formData = FormData.fromMap({
      'user': user,
      'video': video,
      'hour': hour,
      'minute': minute,
      'second': second,
    });
    final dio = Dio();
    final response = await dio.post(ip + "/API/saveHistory/", data: formData);
    if (response.statusCode == 200) {
      print('ok');
      return;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Content>> getHistory(int id) async {
    FormData formData = FormData.fromMap({
      'user': id,
    });
    final dio = Dio();
    final response = await dio.post(ip + "/API/getHistory/", data: formData);
    if (response.statusCode == 200) {
      final List<Content> data = Content.listFromJson(response.data);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static void changeSession(int id, bool session) async {
    FormData formData = FormData.fromMap({
      'id': id,
      'session': session,
    });
    final dio = Dio();
    final response = await dio.post(ip + "/API/changeSession/", data: formData);
    if (response.statusCode == 200) {
      print('ok');
      return;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
