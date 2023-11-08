import 'dart:convert';

import 'package:flutter/material.dart';

class Content {
  final String name;
  final String imageUrl;
  String titleImageUrl;
  String videoUrl;
  String description;
  Color color;
  String cardImage;
  String banner;

  Content({
    this.name = '',
    this.banner ='',
    this.imageUrl = '',
    this.titleImageUrl = '',
    this.videoUrl = '',
    this.description = '',
    this.cardImage = '',
    this.color = Colors.red,
  });
  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      banner: json['banner'],
      name: json['videoName'],
      imageUrl: json['image1'],
      titleImageUrl: json['image2'] ?? '',
      videoUrl: json['link'] ?? '',
      description: json['description'] ?? '',
      color: Color(int.parse(json['color'] ?? '0xFF000000')),
    );
  }

  static List<Content> listFromJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Content>((json) => Content.fromJson(json)).toList();
  }
}
