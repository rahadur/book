import 'package:book/config/environment.dart';
import 'package:book/screen/book_details_screen.dart';
import 'package:book/screen/chapter_list_screen.dart';
import 'package:book/screen/connectivity_listener.dart';
import 'package:book/screen/home_screen.dart';
import 'package:book/screen/reader_screen.dart';
import 'package:flutter/material.dart';

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Environment.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: '/',
      routes: {
        // '/': (context) => const BookListScreen(),
        '/details': (context) => const BookDetailsScreen(),
        '/chapters': (context) => const ChapterListScreen(),
        '/reader': (context) => const ReaderScreen(),
      },
      home: ConnectivityListener(child: HomeScreen()),
    );
  }
}
