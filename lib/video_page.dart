import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPAge extends StatefulWidget {
  const VideoPAge({Key? key}) : super(key: key);

  @override
  State<VideoPAge> createState() => _VideoPAgeState();
}

class _VideoPAgeState extends State<VideoPAge> {
  late YoutubePlayerController _controller;
  String videoUrl = "https://youtu.be/yNre5VJo1L8";

  @override
  void initState() {
    super.initState();
    String videoID = YoutubePlayer.convertUrlToId(videoUrl)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoID,
      flags: const YoutubePlayerFlags(
        enableCaption: true,
        autoPlay: false,
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
      body: SafeArea(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(controller: _controller),
          builder: (context, player) {
            return Column(
              children: [
                player,
              ],
            );
          },
        ),
      ),
    );
  }
}
