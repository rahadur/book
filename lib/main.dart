import 'dart:async';

import 'package:book/book.dart';
import 'package:book/providers/app_info_provider.dart';
import 'package:book/providers/book_provider.dart';
import 'package:book/providers/chapter_provider.dart';
import 'package:book/providers/content_provider.dart';
import 'package:book/providers/text_formate_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppInfoProvider()),
        ChangeNotifierProxyProvider<AppInfoProvider, BookProvider>(
          create: (_) => BookProvider(),
          update: (_, appInfo, book) {
            book ??= BookProvider();
            book.fetchBooks(appInfo.appInfo);
            return book;
          },
        ),
        // ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProxyProvider<BookProvider, ChapterProvider>(
          create: (_) => ChapterProvider(),
          update: (_, book, chapter) {
            chapter ??= ChapterProvider();
            chapter.fetchChapters(book.selectedBook!.id);
            return chapter;
          },
        ),
        // ChangeNotifierProvider(create: (_) => ChapterProvider()),
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => TextFormateProvider())
      ],
      child: const BookApp(),
    ),
  );
}
