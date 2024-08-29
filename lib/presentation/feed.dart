import 'package:assignment/providers/video_provider.dart';
import 'package:assignment/presentation/reply_feed.dart';
import 'package:assignment/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late VideoProvider videoProvider;
  PageController mainPageController = PageController();
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
          SizeConfig().init(context);
          return vidProviderValue.vids.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Stack(
                  children: [
                    PageView.builder(
                      controller: mainPageController,
                      scrollDirection: Axis.vertical,
                      itemCount: vidProviderValue.vids.length,
                      itemBuilder: (context, indexb) {
                        return ReplyFeed(video: vidProviderValue.vids[indexb]);
                      },
                    ),
                    Positioned(
                      right: 20,
                      top: vidProviderValue.vids.length == 3
                          ? 202
                          : vidProviderValue.vids.length == 1
                              ? 238
                              : 220,
                      child: SmoothPageIndicator(
                        controller: mainPageController,
                        axisDirection: Axis.vertical,
                        count: vidProviderValue.vids.length,
                        effect: ScrollingDotsEffect(
                            maxVisibleDots: 3,
                            fixedCenter: true,
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: Colors.white,
                            dotColor: Colors.grey),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
