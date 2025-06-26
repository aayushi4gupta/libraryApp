import 'package:equatable/equatable.dart';
import 'package:library_app/domain/entity/book.dart';

class BookState extends Equatable {
  final List<Book> allBooks;
  final List<Book> visibleBooks;
  final String searchQuery;

  const BookState({
    this.allBooks = const [],
    this.visibleBooks = const [],
    this.searchQuery = '',
  });

  BookState copyWith({
    List<Book>? allBooks,
    List<Book>? visibleBooks,
    String? searchQuery,
  }) {
    return BookState(
      allBooks: allBooks ?? this.allBooks,
      visibleBooks: visibleBooks ?? this.visibleBooks,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [allBooks, visibleBooks, searchQuery];
}