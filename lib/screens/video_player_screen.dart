import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:netflix_mobile/data/api.dart';
import 'package:netflix_mobile/models/models.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Content movie;

  VideoPlayerScreen({required this.movie});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(API.ip + widget.movie.videoUrl));
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
      autoPlay: true,
      looping: false,
      optionsTranslation: OptionsTranslation(
        playbackSpeedButtonText: 'Tốc độ phát lại',
        subtitlesButtonText: 'Phụ đề',
        cancelButtonText: 'Hủy',
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: AspectRatio(
                    aspectRatio: _chewieController.aspectRatio!,
                    child: Chewie(
                      controller: _chewieController,
                    )),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                ],
              )
            ],
          ),
        ));
  }
}
