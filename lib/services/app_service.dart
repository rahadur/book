import 'dart:convert';
import 'package:book/config/environment.dart';
import 'package:book/models/app_info.dart';
import 'package:http/http.dart' as http;

class AppInfoService {
  Future<AppInfo> fetchAppInfo() async {
    final params = {
      'fields[]': ['*', 'related_books.book', 'books.book'],
    };

    final response = await http.get(Uri.https(
        Environment.apiBaseUrl, '/items/apps/${Environment.appId}', params));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['data'];
      return AppInfo.fromJson(json);
    } else {
      throw Exception('Failed to load app info');
    }
  }
}
