import 'package:book/models/content.dart';
import 'package:flutter/material.dart';

class ContentProvider with ChangeNotifier {
  ChapterContent? _selectedSection;
  double _fontSize = 16.0;
  Color _backgroundColor = Colors.white;
  TextAlign _textAlign = TextAlign.left;

  ChapterContent? get selectedSection => _selectedSection;
  double get fontSize => _fontSize;
  Color get backgroundColor => _backgroundColor;
  TextAlign get textAlign => _textAlign;

  void selectSection(ChapterContent section) {
    _selectedSection = section;
    notifyListeners();
  }

  void setFontSize(double fontSize) {
    _fontSize = fontSize;
    notifyListeners();
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  void setTextAlign(TextAlign align) {
    _textAlign = align;
    notifyListeners();
  }
}
