import 'package:flutter/material.dart';
import "package:digital_talking_book_recorder/book_screen.dart";
import "dart:io";

Future<void> main() async {
  runApp(MyApp());
  var appDir = Directory("/storage/emulated/0/digital_talking_books");
  if (!await appDir.exists()) {
    appDir.create();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/': (context) => BookScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
