import "package:flutter/material.dart";
import "package:path/path.dart" as path;
import "package:digital_talking_book_recorder/chapter_screen.dart";

class BookCard extends StatefulWidget {
  final String bookName;

  BookCard({required this.bookName});
  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              // Within the `FirstRoute` widget
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChapterScreen(
                          bookName: widget.bookName,
                        )),
              );
            },
            leading: Icon(Icons.book),
            title: Text(widget.bookName),
            subtitle: Text(
              'status ',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  // Perform some action
                },
                child: Text('resume recording'),
              ),
              TextButton(
                onPressed: () {
                  // Perform some action
                },
                child: Text('mark as  finished'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookCardList extends StatefulWidget {
  final List<String> bookPaths;
  BookCardList({required this.bookPaths});
  @override
  _BookCardListState createState() => _BookCardListState();
}

class _BookCardListState extends State<BookCardList> {
  List<BookCard> books = [];

  @override
  void initState() {
    super.initState();
    for (var p in widget.bookPaths) {
      books.add(BookCard(
        bookName: path.basename(p),
      ));
      print(path.basename(p));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.bookPaths.length,
      itemBuilder: (context, index) {
        return BookCard(
          bookName: path.basename(widget.bookPaths[index]),
        );
      },
    );
  }
}
