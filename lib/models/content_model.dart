import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Content {
  final String name;
  final String imageUrl;
  String titleImageUrl;
  String videoUrl;
  String description;
  Color color;

  Content({
    required this.name,
    required this.imageUrl,
    this.titleImageUrl = '',
    this.videoUrl = '',
    this.description = '',
    this.color = Colors.red,
  });
  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      name: json['name'],
      imageUrl: json['imageUrl'],
      titleImageUrl: json['titleImageUrl'] ??
          '',
      videoUrl: json['videoUrl'] ?? '',
      description: json['description'] ?? '',
      color: Color(int.parse(json['color'] ?? '0xFF000000')),
    );
  }
  
  static List<Content> listFromJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Content>((json) => Content.fromJson(json)).toList();
  }
}
