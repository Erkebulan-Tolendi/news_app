import 'package:bloc/bloc.dart';
import 'package:news_app/api/tmdb_api.dart';

import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final TmdbApi tmdbApi;

  NewsBloc(this.tmdbApi) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await tmdbApi.fetchNews(event.page);
        emit(NewsLoaded(news));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}
