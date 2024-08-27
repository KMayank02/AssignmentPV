import 'package:assignment/domain/video_model.dart';
import 'package:assignment/utils/size_config.dart';
import 'package:assignment/widgets/overlay_icons.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class VideoInterface extends StatefulWidget {
  final VideoData video;
  const VideoInterface({super.key, required this.video});

  @override
  State<VideoInterface> createState() => _VideoInterfaceState();
}

class _VideoInterfaceState extends State<VideoInterface> {
  late CachedVideoPlayerPlusController videoPlayerController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() {
    videoPlayerController =
        CachedVideoPlayerPlusController.networkUrl(widget.video.videoLink)
          ..setLooping(false)
          ..addListener(() {
            setState(() {});
          })
          ..initialize().then((value) {
            videoPlayerController.play();
            setState(() {});
          });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: videoPlayerController.value.isInitialized
              ? CachedVideoPlayerPlus(videoPlayerController)
              : Container(),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            videoPlayerController.value.isPlaying
                ? videoPlayerController.pause()
                : videoPlayerController.play();
          },
          child: videoPlayerController.value.isPlaying
              ? Container()
              : videoPlayerController.value.isBuffering
                  ? Container(
                      alignment: Alignment.center,
                      color: Colors.black26,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      color: Colors.black26,
                      child: Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 80),
                    ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      OverlayIcons(
                          text: widget.video.upvoteCount.toString(),
                          icon: Icons.favorite,
                          onTap: () {}),
                      verticalSpaceTiny,
                      OverlayIcons(
                          text: widget.video.commentCount.toString(),
                          icon: CupertinoIcons.bubble_middle_bottom,
                          onTap: () {}),
                      verticalSpaceTiny,
                      OverlayIcons(
                          text: 'Share',
                          icon: Icons.share_outlined,
                          onTap: () {}),
                      verticalSpaceDefault,
                      verticalSpaceDefault,
                      Text(
                        widget.video.title,
                        style: TextStyle(color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                verticalSpaceDefault,
                VideoProgressIndicator(
                  videoPlayerController,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.white,
                  ),
                ),
                verticalSpaceLarge,
              ],
            ),
          ),
        )
      ],
    );
  }
}
