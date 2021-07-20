import "package:flutter/material.dart";

class BookCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.book),
            title: Text('book name '),
            subtitle: Text(
              'status ',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          /*
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ), */
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

class BookCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BookCard();
  }
}
