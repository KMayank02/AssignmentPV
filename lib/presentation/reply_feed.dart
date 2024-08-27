import 'package:assignment/domain/video_model.dart';
import 'package:assignment/widgets/video_interface.dart';
import 'package:assignment/providers/replyProvider.dart';
import 'package:assignment/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReplyFeed extends StatefulWidget {
  final VideoData video;
  const ReplyFeed({super.key, required this.video});

  @override
  State<ReplyFeed> createState() => _ReplyFeedState();
}

class _ReplyFeedState extends State<ReplyFeed> {
  void initState() {
    Future.delayed(Duration.zero, () {
      final replyProvider = Provider.of<ReplyProvider>(context, listen: false);
      replyProvider.fetchReplies(widget.video.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<ReplyProvider>(
      builder: (BuildContext context, replyValue, Widget? child) {
        List<VideoData> vids = [widget.video];
        vids.addAll(replyValue.replies);
        return CarouselSlider.builder(
            itemCount: vids.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            vids[index].thumbnailUrl),
                        fit: BoxFit.cover)),
                child: VideoInterface(
                  video: vids[index],
                ),
              );
            },
            options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: false,
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1,
              autoPlay: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {},
            ));
      },
    );
  }
}
