import 'package:assignment/providers/video_provider.dart';
import 'package:assignment/presentation/reply_feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late VideoProvider videoProvider;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      videoProvider = Provider.of<VideoProvider>(context, listen: false);
      videoProvider.fetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<VideoProvider>(
        builder: (context, vidProviderValue, child) {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: vidProviderValue.vids.length,
            itemBuilder: (context, indexb) {
              return ReplyFeed(video: vidProviderValue.vids[indexb]);
            },
          );
        },
      ),
    );
  }
}
