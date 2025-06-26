import 'package:library_app/domain/entity/book.dart';
import 'package:library_app/domain/repository/book_repository.dart';

class GetBooks {
  final BookRepository repository;
  GetBooks(this.repository);
  Future<List<Book>> call() => repository.getBooks();
}