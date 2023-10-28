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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(API.ip + widget.movie.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: _controller.value.isInitialized
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    CustomControls(
                        _controller), // Custom control buttons and seek bar
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ],
    ));
  }
}

class CustomControls extends StatelessWidget {
  final VideoPlayerController controller;

  CustomControls(this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.fast_rewind),
              onPressed: () {
                // Implement rewind logic here
              },
            ),
            IconButton(
              icon: controller.value.isPlaying
                  ? IconMaker(Icons.pause)
                  : IconMaker(Icons.play_arrow),
              onPressed: () {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.fast_forward),
              onPressed: () {
                // Implement fast forward logic here
              },
            ),
          ],
        ),
        VideoProgressIndicator(
          controller,
          allowScrubbing: true,
          padding: EdgeInsets.all(8.0),
        ),
      ],
    );
  }
}

Icon IconMaker(IconData a) {
  return Icon(
    a,
    color: Colors.white,
  );
}
