import 'package:flutter/material.dart';
import 'package:netflix_mobile/data/api.dart';
import 'package:netflix_mobile/models/content_model.dart';
import 'package:netflix_mobile/screens/screens.dart';
import 'package:video_player/video_player.dart';
import 'widgets.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;
  const ContentHeader({super.key, required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(
        featuredContent: featuredContent,
      ),
      desktop: _ContentHeaderDesktop(
        featuredContent: featuredContent,
      ),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;
  const _ContentHeaderMobile({required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(API.ip + featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 110.0,
          left: 75,
          right: 75,
          child: SizedBox(
            child: Image.network(
              API.ip + featuredContent.titleImageUrl,
            ),
            width: 100.0,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: 'Danh sách',
                onTap: () => print('list'),
              ),
              _PlayButton(videoContent: featuredContent),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: 'Thông tin',
                onTap: () => print('info'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;
  const _ContentHeaderDesktop({required this.featuredContent});

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  late VideoPlayerController _videoController;
  bool _isMuted = true;
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(
        Uri.parse(API.ip + widget.featuredContent.videoUrl))
      ..initialize().then((_) => setState(() {}))
      ..setVolume(0)
      ..play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
              aspectRatio: _videoController.value.isInitialized
                  ? _videoController.value.aspectRatio
                  : 2.344,
              child: _videoController.value.isInitialized
                  ? VideoPlayer(_videoController)
                  : API.loadImageUrl(widget.featuredContent.imageUrl)),
          Positioned(
            bottom: -1.0,
            left: 0,
            right: 0,
            child: AspectRatio(
              aspectRatio: _videoController.value.isInitialized
                  ? _videoController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: API.loadImageUrl(widget.featuredContent.titleImageUrl),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.featuredContent.description,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(2.0, 4.0),
                          blurRadius: 6.0,
                        )
                      ]),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    _PlayButton(videoContent: widget.featuredContent),
                    const SizedBox(
                      width: 16.0,
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith((states) =>
                              const EdgeInsets.fromLTRB(25, 10, 30, 10)),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white)),
                      onPressed: () => print('More'),
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      label: Text(
                        'Thông tin',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    if (_videoController.value.isInitialized)
                      IconButton(
                        icon: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                        ),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () => setState(() {
                          _isMuted
                              ? _videoController.setVolume(100)
                              : _videoController.setVolume(0);
                          _isMuted = _videoController.value.volume == 0;
                        }),
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final Content videoContent;
  _PlayButton({required this.videoContent});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.white),
          padding: MaterialStateProperty.resolveWith(
            (states) => !Responsive.isDesktop(context)
                ? const EdgeInsets.fromLTRB(15, 5, 20, 5)
                : const EdgeInsets.fromLTRB(25, 10, 30, 10),
          ),
          iconColor: MaterialStateColor.resolveWith((states) => Colors.black)),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(movie: videoContent))),
      icon: const Icon(
        Icons.play_arrow,
        size: 30.0,
      ),
      label: const Text(
        'Phát',
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }
}
