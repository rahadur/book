import 'package:book/providers/app_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppInfoProvider>(context, listen: false);
    return Scaffold(
      // appBar: AppBar(title: Text(Environment.appTitle)),
      body: FutureBuilder(
        future: provider.loadAppInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const BookListScreen();
          }
        },
      ),
    );
  }
}
