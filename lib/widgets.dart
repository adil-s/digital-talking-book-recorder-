import "package:flutter/material.dart";

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
  @override
  _BookCardListState createState() => _BookCardListState();
}

class _BookCardListState extends State<BookCardList> {
  List<BookCard> books = [
    BookCard(
      bookName: "a",
    ),
    BookCard(
      bookName: "b",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: books,
    );
  }
}
