import 'package:library_app/data/data_sources/book_local_data_source.dart';
import 'package:library_app/domain/entity/book.dart';
import 'package:library_app/domain/repository/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookLocalDataSource local;
  BookRepositoryImpl(this.local);

  @override
  Future<List<Book>> getBooks() async {
    final models = await local.getBooksFromJson();
    return models.map((m) => m.toEntity()).toList();
  }
}
