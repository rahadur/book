import 'package:book/models/app_info.dart';
import 'package:book/services/app_service.dart';
import 'package:flutter/material.dart';

class AppInfoProvider with ChangeNotifier {
  AppInfo? _appInfo;
  bool isLoading = false;

  AppInfo? get appInfo => _appInfo;

  final _appInfoService = AppInfoService();

  get name => null;

  Future<void> loadAppInfo() async {
    isLoading = true;
    _appInfo = await _appInfoService.fetchAppInfo();
    isLoading = false;
    notifyListeners();
  }
}
