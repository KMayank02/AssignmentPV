import 'package:assignment/domain/video_fetch_service.dart';
import 'package:assignment/domain/video_model.dart';
import 'package:flutter/material.dart';

class VideoProvider extends ChangeNotifier {
  final videoService = VideoFetcher();
  bool isLoading = false;
  List<VideoData> vids = [];
  List<VideoData> replies = [];

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    vids = await videoService.fetchVideos();
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchReplies(int id) async {
    isLoading = true;
    notifyListeners();

    vids = await videoService.fetchChildVideos(id);
    isLoading = false;
    notifyListeners();
  }
}
