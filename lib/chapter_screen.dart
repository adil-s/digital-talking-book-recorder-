import 'package:flutter/material.dart';
import 'package:digital_talking_book_recorder/record_screen.dart';
import 'package:digital_talking_book_recorder/audio_player.dart';
import "package:path/path.dart" as path;
import 'dart:io';

class ChapterScreen extends StatefulWidget {
  final String bookName;
  ChapterScreen({required this.bookName});
  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('enter chapter name:'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "chapter name"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    String? userInput = valueText;
                    List<String?> fileName = [userInput, ".m4a"];
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AudioRecorder(
                        path: path.join(
                            "/storage/emulated/0/digital_talking_books",
                            widget.bookName,
                            fileName.join()),
                      );
                    }));
                  });
                },
              ),
            ],
          );
        });
  }

  String? userInput;
  String? valueText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName),
      ),
      floatingActionButton: TextButton(
        onPressed: () => _displayTextInputDialog(context),
        child: Text("add chapter"),
      ),
      body: ChapterCardList(
        bookName: widget.bookName,
      ),
    );
  }
}

class ChapterCard extends StatefulWidget {
  final String chapterName;
  final String bookName;

  ChapterCard({required this.chapterName, required this.bookName});
  @override
  _ChapterCardState createState() => _ChapterCardState();
}

class _ChapterCardState extends State<ChapterCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              List<String> fileName = [widget.chapterName, ".m4a"];
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AudioPlayer(
                          path: path.join(
                              "/storage/emulated/0/digital_talking_books",
                              widget.bookName,
                              fileName.join()),
                        )),
              );
            },
            leading: Icon(Icons.book),
            title: Text(widget.chapterName),
          ),
        ],
      ),
    );
  }
}

class ChapterCardList extends StatefulWidget {
  final String bookName;
  ChapterCardList({required this.bookName});
  @override
  _ChapterCardListState createState() => _ChapterCardListState();
}

class _ChapterCardListState extends State<ChapterCardList> {
  List<String> chapterPaths = ["no"];
  Directory appDir = Directory("/storage/emulated/0/digital_talking_books");
  @override
  void initState() {
    super.initState();
    _getChapterPaths();
  }

  List<String>? _getChapterPaths() {
    chapterPaths = [];
    var f = () {
      for (var d
          in Directory(path.join(appDir.path, widget.bookName)).listSync()) {
        print(d.path);
        chapterPaths.add(path.basenameWithoutExtension(d.path));
      }
    };
    f();
    return chapterPaths;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chapterPaths.length,
      itemBuilder: (context, index) => ChapterCard(
        chapterName: chapterPaths[index],
        bookName: widget.bookName,
      ),
    );
  }
}
