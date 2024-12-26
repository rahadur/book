import 'package:book/config/environment.dart';
import 'package:book/providers/app_info_provider.dart';
import 'package:book/screen/book_details_screen.dart';
import 'package:book/screen/book_list_screen.dart';
import 'package:book/screen/chapter_list_screen.dart';
import 'package:book/screen/reader_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: FutureBuilder(
          future: Provider.of<AppInfoProvider>(context, listen: false)
              .loadAppInfo(),
          builder: (context, snapshot) {
            final appInfo = context.read<AppInfoProvider>();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                appBar: AppBar(title: Text(appInfo.name ?? '')),
                body: const Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')));
            } else {
              return const BookListScreen();
            }
          }),
    );
  }
}
