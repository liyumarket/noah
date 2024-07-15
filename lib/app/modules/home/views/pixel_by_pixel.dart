import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;

  VideoPlayerScreen({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.url != '') {
      final videoId = YoutubePlayer.convertUrlToId(widget.url);
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          showLiveFullscreenButton: false,
          controlsVisibleAtStart: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      return AspectRatio(
        aspectRatio: orientation == Orientation.portrait
            ? 9 / 16
            : 4, // Aspect ratio of the YouTube video
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: ColorConstants.primaryColor,
          onReady: () {},
        ),
      );
    });
  }
}
