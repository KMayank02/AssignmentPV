import 'package:assignment/providers/replyProvider.dart';
import 'package:assignment/providers/video_provider.dart';
import 'package:assignment/presentation/feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VideoProvider>(
          create: (context) {
            return VideoProvider();
          },
        ),
        ChangeNotifierProvider<ReplyProvider>(
          create: (context) {
            return ReplyProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Feed(),
      ),
    );
  }
}
