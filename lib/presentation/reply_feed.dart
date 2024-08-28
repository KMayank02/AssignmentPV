import 'package:assignment/domain/video_model.dart';
import 'package:assignment/widgets/video_interface.dart';
import 'package:assignment/providers/replyProvider.dart';
import 'package:assignment/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReplyFeed extends StatefulWidget {
  final VideoData video;
  const ReplyFeed({super.key, required this.video});

  @override
  State<ReplyFeed> createState() => _ReplyFeedState();
}

class _ReplyFeedState extends State<ReplyFeed> {
  int vis = 1;
  CarouselSliderController carouselSliderController =
      CarouselSliderController();
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
            carouselController: carouselSliderController,
            itemCount: vids.length,
            itemBuilder: (context, index, realIndex) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                vids[index].thumbnailUrl),
                            fit: BoxFit.cover)),
                    child: VideoInterface(
                      video: vids[index],
                    ),
                  ),
                  vis == 1 && index!=0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.09),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          height: 100,
                          width: SizeConfig.screenWidth,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(220, 155, 166, 225),
                                Color.fromARGB(220, 155, 150, 151),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            vids[0].thumbnailUrl),
                                        fit: BoxFit.cover),
                                  ),
                                  child: GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.black26,
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    onTap: () {
                                      carouselSliderController.jumpToPage(0);
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Response to: ',
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 23, 23, 60),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${vids[0].firstName}${vids[0].lastName}@${vids[0].username}',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      verticalSpaceTiny,
                                      Text(
                                        vids[0].title,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 23, 23, 60),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          vis = 0;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.black38,
                                        size: 18,
                                        weight: 2,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),
                ],
              );
            },
            options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: false,
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1,
              autoPlay: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  vis = 1;
                });
              },
            ));
      },
    );
  }
}
