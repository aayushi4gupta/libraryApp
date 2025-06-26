import 'package:library_app/domain/entity/book.dart';


abstract class BookRepository {
  Future<List<Book>> getBooks();
}