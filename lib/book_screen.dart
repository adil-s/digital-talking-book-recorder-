import "dart:io";
import "package:flutter/material.dart";
import "package:digital_talking_book_recorder/widgets.dart";
import "package:path/path.dart" as path;

class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  TextEditingController _textFieldController = TextEditingController();
  List<String> bookDirs = ["no"];
  Directory appDir = Directory("/storage/emulated/0/digital_talking_books");

  List<String>? _getBookDirs() {
    bookDirs = [];
    var f = () {
      for (var d in appDir.listSync()) {
        print(d.path);
        bookDirs.add(d.path);
      }
    };
    f();
    return bookDirs;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('enter book name:'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "book name"),
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
                    userInput = valueText;
                    Navigator.pop(context);
                    var newDirPath = path.join(appDir.path, userInput);
                    Directory(newDirPath).createSync();
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
        title: Text("Digital audio book recorder"),
      ),
      body: BookCardList(
        bookPaths: _getBookDirs() != null ? bookDirs : [" no "],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: " New book",
        onPressed: () {
          _displayTextInputDialog(context);
        },
      ),
    );
  }
}
