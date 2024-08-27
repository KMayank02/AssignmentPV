import 'package:assignment/domain/video_model.dart';
import 'package:dio/dio.dart';

class VideoFetcher {
  String baseUrl = 'https://api.wemotions.app/feed?page=1';
  String childUrl = 'https://api.wemotions.app/posts/';

  List<DioExceptionType> dioErrors = [
    DioExceptionType.connectionTimeout,
    DioExceptionType.sendTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.badCertificate,
    DioExceptionType.badResponse,
    DioExceptionType.cancel,
    DioExceptionType.connectionError,
    DioExceptionType.unknown,
  ];

  final Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10)));

  Future<List<VideoData>> fetchVideos() async {
    try {
      Response response = await dio.get(baseUrl);

      List data = response.data['posts'];
      List<VideoData> vids =
          data.map((data) => VideoData.fromJson(data)).toList();
      return vids;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        rethrow;
      }
      if (dioErrors.contains(e.type)) {
        rethrow;
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<VideoData>> fetchChildVideos(int id) async {
    try {
      Response response = await dio.get('$childUrl$id/replies');

      List data = response.data['post'];
      List<VideoData> vids =
          data.map((data) => VideoData.fromJson(data)).toList();
      return vids;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        rethrow;
      }
      if (dioErrors.contains(e.type)) {
        rethrow;
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
