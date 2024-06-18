import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/tmdb_api.dart';
import 'package:news_app/bloc/news/news_bloc.dart';
import 'package:news_app/pages/pages/news_list_page.dart';

void main() {
  final TmdbApi tmdbApi = TmdbApi();

  runApp(MyApp(tmdbApi: tmdbApi));
}

class MyApp extends StatelessWidget {
  final TmdbApi tmdbApi;

  const MyApp({Key? key, required this.tmdbApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.indigo[700],
      ),
      title: 'News App',
      home: BlocProvider(
        create: (context) => NewsBloc(tmdbApi),
        child: NewsListPage(),
      ),
    );
  }
}
