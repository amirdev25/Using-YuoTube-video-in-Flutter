import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You tube"),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  String videoUrl = "https://youtu.be/7cX0x66iFyo";
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late String videoId;

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
      // ..addListener(_listener);

    _idController = TextEditingController();
    _seekToController = TextEditingController();
  }

  // void _listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {});
  //   }
  // }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _seekToController.dispose();
    _idController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.blue,
      child: VisibilityDetector(
        key: const Key("unique key"),
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 0) {
            _controller.pause();
          } else {
            _controller.value.isPlaying
                ? _controller.play()
                : _controller.pause();
          }
        },
        child: YoutubePlayerBuilder(
          // onEnterFullScreen: (){},
          // onExitFullScreen: () {
          //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          // },
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            topActions: [
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  _controller.metadata.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
            onReady: () {
              _isPlayerReady = true;
              // _controller.addListener(_listener);
            },
            onEnded: (data) {},
          ),
          builder: (context, player) {
            return Scaffold(
              body: ListView(
                children: [
                  player,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
