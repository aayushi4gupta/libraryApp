import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/book_bloc.dart';
import '../bloc/book_state.dart';
import '../bloc/book_event.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          final favorites = state.allBooks.where((b) => b.isFavorite).toList();
          return favorites.isEmpty
              ? const Center(child: Text('No favorite books yet.'))
              : ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final book = favorites[index];
                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: book.coverUrl,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
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