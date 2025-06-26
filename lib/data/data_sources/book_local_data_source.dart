import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/book_model.dart';

class BookLocalDataSource {
  Future<List<BookModel>> getBooksFromJson() async {
    final String jsonStr = await rootBundle.loadString('assets/books.json');
    final List data = json.decode(jsonStr);
    return data.map((e) => BookModel.fromJson(e)).toList();
  }
}