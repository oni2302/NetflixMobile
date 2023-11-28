import 'dart:convert';

import 'package:flutter/material.dart';

class Content {
  final int id;
  final String name;
  final String imageUrl;
  String titleImageUrl;
  String videoUrl;
  String description;
  Color color;
  String cardImage;
  String banner;
  int hour=0,minute=0,second=0;

  Content({
    this.id=-1, 
    this.name = '',
    this.banner = '',
    this.imageUrl = '',
    this.titleImageUrl = '',
    this.videoUrl = '',
    this.description = '',
    this.cardImage = '',
    this.color = Colors.red,
    this.hour=0,
    this.minute=0,
    this.second=0
  });
  factory Content.fromJson(Map<String, dynamic> json) {
    if(json['hour']==null) json['hour']=0;
    if(json['minute']==null) json['minute']=0;
    if(json['second']==null) json['second']=0;
    return Content(
      id:json['id'],
      banner: json['banner'],
      name: json['videoName'],
      imageUrl: json['image1'],
      titleImageUrl: json['image2'] ?? '',
      videoUrl: json['link'] ?? '',
      description: json['description'] ?? '',
      color: Color(int.parse(json['color'] ?? '0xFF000000')),
      hour: json['hour'],
      minute: json['minute'],
      second: json['second']
    );
  }

  static List<Content> listFromJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Content>((json) => Content.fromJson(json)).toList();
  }
}
