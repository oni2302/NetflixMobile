import 'package:flutter/material.dart';
import 'package:netflix_mobile/data/api.dart';
import 'package:netflix_mobile/screens/video_player_screen.dart';

import '../models/models.dart';

class HistoryList extends StatelessWidget {
  final String title;
  final List<Content> contentList;
  final bool isOriginal;
  const HistoryList(
      {super.key,
      required this.title,
      required this.contentList,
      this.isOriginal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: isOriginal ? 500.0 : 220.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: contentList.length,
              itemBuilder: (BuildContext context, int index) {
                final Content content = contentList[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VideoPlayerScreen(movie: content))),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    height: isOriginal ? 400.0 : 200.0,
                    width: isOriginal ? 200.0 : 130.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(API.ip + content.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
