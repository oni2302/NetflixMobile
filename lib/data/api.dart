import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netflix_mobile/models/models.dart';

class API {
  static final String ip = "http://192.168.145.170";
  //Fetch JSON data from API;
  static Future<Content> fetchData(String url) async {
    final dio = Dio();
    final response = await dio.get(ip + "/" + url);

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
}
