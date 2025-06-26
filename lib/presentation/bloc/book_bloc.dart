import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/domain/use_cases/get_books.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBooks getBooks;

  BookBloc(this.getBooks) : super(const BookState()) {
    on<LoadBooks>(_onLoadBooks);
    on<ToggleFavorite>(_onToggleFavorite);
    on<SearchBooks>(_onSearchBooks);
  }

  void _onLoadBooks(LoadBooks event, Emitter<BookState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final books = await getBooks();
    final favIds = prefs.getStringList('favorites')?.map(int.parse).toSet() ?? {};
    final updated = books.map((b) => b.copyWith(isFavorite: favIds.contains(b.id))).toList();
    emit(state.copyWith(allBooks: updated, visibleBooks: updated));
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<BookState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedBooks = state.allBooks.map((b) {
      return b.id == event.bookId ? b.copyWith(isFavorite: !b.isFavorite) : b;
    }).toList();
    final filtered = state.searchQuery.isEmpty
      ? updatedBooks
      : updatedBooks.where((b) => b.title.toLowerCase().contains(state.searchQuery.toLowerCase())).toList();
    final favIds = updatedBooks.where((b) => b.isFavorite).map((b) => b.id.toString()).toList();
    await prefs.setStringList('favorites', favIds);
    emit(state.copyWith(allBooks: updatedBooks, visibleBooks: filtered));
  }

  void _onSearchBooks(SearchBooks event, Emitter<BookState> emit) {
    final filtered = state.allBooks.where((b) => b.title.toLowerCase().contains(event.query.toLowerCase())).toList();
    emit(state.copyWith(searchQuery: event.query, visibleBooks: filtered));
  }
}