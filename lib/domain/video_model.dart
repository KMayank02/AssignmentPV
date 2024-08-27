// To parse this JSON data, do
//
//     final videoData = videoDataFromJson(jsonString);

import 'dart:convert';

VideoData videoDataFromJson(String str) => VideoData.fromJson(json.decode(str));

String videoDataToJson(VideoData data) => json.encode(data.toJson());

class VideoData {
  int id;
  List<dynamic> category;
  String slug;
  dynamic parentVideoId;
  int childVideoCount;
  String title;
  String identifier;
  int commentCount;
  int upvoteCount;
  int viewCount;
  int exitCount;
  int ratingCount;
  int averageRating;
  int shareCount;
  Uri videoLink;
  String contractAddress;
  String chainId;
  String chartUrl;
  BaseToken baseToken;
  bool isLocked;
  int createdAt;
  String firstName;
  String lastName;
  String username;
  bool upvoted;
  bool bookmarked;
  String thumbnailUrl;
  bool following;
  String pictureUrl;

  VideoData({
    required this.id,
    required this.category,
    required this.slug,
    required this.parentVideoId,
    required this.childVideoCount,
    required this.title,
    required this.identifier,
    required this.commentCount,
    required this.upvoteCount,
    required this.viewCount,
    required this.exitCount,
    required this.ratingCount,
    required this.averageRating,
    required this.shareCount,
    required this.videoLink,
    required this.contractAddress,
    required this.chainId,
    required this.chartUrl,
    required this.baseToken,
    required this.isLocked,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.upvoted,
    required this.bookmarked,
    required this.thumbnailUrl,
    required this.following,
    required this.pictureUrl,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        id: json["id"],
        category: List<dynamic>.from(json["category"].map((x) => x)),
        slug: json["slug"],
        parentVideoId: json["parent_video_id"],
        childVideoCount: json["child_video_count"],
        title: json["title"],
        identifier: json["identifier"],
        commentCount: json["comment_count"],
        upvoteCount: json["upvote_count"],
        viewCount: json["view_count"],
        exitCount: json["exit_count"],
        ratingCount: json["rating_count"],
        averageRating: json["average_rating"],
        shareCount: json["share_count"],
        videoLink: Uri.parse(json["video_link"]) ,
        contractAddress: json["contract_address"],
        chainId: json["chain_id"],
        chartUrl: json["chart_url"],
        baseToken: BaseToken.fromJson(json["baseToken"]),
        isLocked: json["is_locked"],
        createdAt: json["created_at"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        upvoted: json["upvoted"],
        bookmarked: json["bookmarked"],
        thumbnailUrl: json["thumbnail_url"],
        following: json["following"],
        pictureUrl: json["picture_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": List<dynamic>.from(category.map((x) => x)),
        "slug": slug,
        "parent_video_id": parentVideoId,
        "child_video_count": childVideoCount,
        "title": title,
        "identifier": identifier,
        "comment_count": commentCount,
        "upvote_count": upvoteCount,
        "view_count": viewCount,
        "exit_count": exitCount,
        "rating_count": ratingCount,
        "average_rating": averageRating,
        "share_count": shareCount,
        "video_link": videoLink,
        "contract_address": contractAddress,
        "chain_id": chainId,
        "chart_url": chartUrl,
        "baseToken": baseToken.toJson(),
        "is_locked": isLocked,
        "created_at": createdAt,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "upvoted": upvoted,
        "bookmarked": bookmarked,
        "thumbnail_url": thumbnailUrl,
        "following": following,
        "picture_url": pictureUrl,
      };
}

class BaseToken {
  String address;
  String name;
  String symbol;
  String imageUrl;

  BaseToken({
    required this.address,
    required this.name,
    required this.symbol,
    required this.imageUrl,
  });

  factory BaseToken.fromJson(Map<String, dynamic> json) => BaseToken(
        address: json["address"],
        name: json["name"],
        symbol: json["symbol"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "name": name,
        "symbol": symbol,
        "image_url": imageUrl,
      };
}
