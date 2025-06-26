import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/data/data_sources/book_local_data_source.dart';
import 'package:library_app/domain/repository/book_repository_impl.dart';
import 'package:library_app/domain/use_cases/get_books.dart';
import 'package:library_app/presentation/bloc/book_bloc.dart';
import 'package:library_app/presentation/bloc/book_event.dart';
import 'package:library_app/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = BookRepositoryImpl(BookLocalDataSource());
  final useCase = GetBooks(repository);

  runApp(MyApp(bookBloc: BookBloc(useCase)..add(LoadBooks())));
}

class MyApp extends StatelessWidget {
  final BookBloc bookBloc;
  const MyApp({super.key, required this.bookBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      home: BlocProvider.value(
        value: bookBloc,
        child: const HomeScreen(),
      ),
    );
  }
}
