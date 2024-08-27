import 'package:assignment/domain/video_fetch_service.dart';
import 'package:assignment/domain/video_model.dart';
import 'package:flutter/material.dart';

class ReplyProvider extends ChangeNotifier {
  final videoService = VideoFetcher();
  bool isLoading = false;
  List<VideoData> replies = [];

  Future<void> fetchReplies(int id) async {
    isLoading = true;
    notifyListeners();

    replies = await videoService.fetchChildVideos(id);
    isLoading = false;
    notifyListeners();
  }
}
