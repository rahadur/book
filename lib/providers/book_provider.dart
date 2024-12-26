import 'package:book/models/app_info.dart';
import 'package:book/models/book.dart';
import 'package:book/services/book_service.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  Book? _primaryBook;
  List<Book> _relatedBooks = [];
  List<Book> _books = [];

  Book? _selectedBook;
  bool isLoading = false;

  final _bookService = BookService();

  Book? get primaryBook => _primaryBook;
  List<Book> get relatedBook => _relatedBooks;
  List<Book> get books => _books;

  Book? get selectedBook => _selectedBook;

  Future<void> fetchBooks(AppInfo? appInfo) async {
    if (appInfo == null) return;
    isLoading = true;
    _primaryBook = await _bookService.fetchBook(appInfo.book);
    _books = await _bookService.fetchBookByIds(appInfo.books);
    _relatedBooks = await _bookService.fetchBookByIds(appInfo.related_books);
    isLoading = false;
    notifyListeners();
  }

  void selectBook(Book book) {
    _selectedBook = book;
    notifyListeners();
  }
}
