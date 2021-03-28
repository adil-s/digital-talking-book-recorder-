import 'dart:async';
import "dart:io";
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import "package:digital_talking_book_recorder/audio_player.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? path;

  @override
  void initState() {
    super.initState();
    Directory str = Directory("/storage/emulated/0/digitalTalkingBookRecorder");
    if (!str.existsSync()) {
      str.create();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: true,
      home: FutureBuilder(
          future: getPath(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return AudioPlayer(path: "/storage/emulated/0/a.mp3");
            } else {
              return Text("can't load");
            }
          }),
    );
  }

  Future<String> getPath() async {
    if (path == null) {
      final dir = await getApplicationDocumentsDirectory();
      path = dir.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.m4a';
    }
    return path!;
  }
}
