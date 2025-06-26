class Book {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    this.isFavorite = false,
  });

  Book copyWith({bool? isFavorite}) => Book(
    id: id,
    title: title,
    author: author,
    coverUrl: coverUrl,
    isFavorite: isFavorite ?? this.isFavorite,
  );
}