abstract class BookEvent {}

class LoadBooks extends BookEvent {}
class ToggleFavorite extends BookEvent {
  final int bookId;
  ToggleFavorite(this.bookId);
}
class SearchBooks extends BookEvent {
  final String query;
  SearchBooks(this.query);
}