import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:noahrealstate/app/modules/home/views/pixel_by_pixel.dart';

import '../controllers/video_player_screen_controller.dart';

class VideoPlayerScreenView extends GetView<VideoPlayerScreenController> {
  const VideoPlayerScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
          ),
          body: VideoPlayerScreen(url: controller.url)),
    );
  }
}
