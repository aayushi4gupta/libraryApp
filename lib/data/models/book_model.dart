
import 'package:library_app/domain/entity/book.dart';

class BookModel {
  final int id;
  final String title;
  final String author;
  final String coverUrl;

  BookModel({required this.id, required this.title, required this.author, required this.coverUrl});

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    id: json['id'],
    title: json['title'],
    author: json['author'],
    coverUrl: json['coverUrl'],
  );

  Book toEntity() => Book(id: id, title: title, author: author, coverUrl: coverUrl);
}