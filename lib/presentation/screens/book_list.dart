import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) => context.read<BookBloc>().add(SearchBooks(query)),
              decoration: const InputDecoration(
                hintText: 'Search books...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.visibleBooks.length,
            itemBuilder: (context, index) {
              final book = state.visibleBooks[index];
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: book.coverUrl,
                  width: 50,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                title: Text(book.title),
                subtitle: Text(book.author),
                trailing: IconButton(
                  icon: Icon(
                    book.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: book.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () => context.read<BookBloc>().add(ToggleFavorite(book.id)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}