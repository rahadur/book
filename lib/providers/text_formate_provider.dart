import 'package:flutter/material.dart';

class TextFormateProvider with ChangeNotifier {
  bool showTextFormat = false;
  double fontSize = 16.0;
  String fontFamily = 'Scala';
  TextAlign textAlign = TextAlign.left;
  Color backgroundColor = const Color(0xFFFFFFFF);
  Color textColor = const Color(0xFF111724);
  double lineHeight = 1.5;

  selectFontSize(double size) {
    fontSize = size;
    notifyListeners();
  }

  selectFontFamily(String font) {
    fontFamily = font;
    notifyListeners();
  }

  selectTextAlgn(TextAlign align) {
    textAlign = align;
    notifyListeners();
  }

  selectBackground(Color bgColor, Color color) {
    backgroundColor = bgColor;
    textColor = color;
    notifyListeners();
  }

  selectLineHeight(double height) {
    lineHeight = height;
    notifyListeners();
  }
}
