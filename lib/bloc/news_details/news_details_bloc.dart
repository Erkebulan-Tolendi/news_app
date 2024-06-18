import 'package:bloc/bloc.dart';
import 'package:news_app/api/tmdb_api.dart';

import 'news_details_event.dart';
import 'news_details_state.dart';

class NewsDetailsBloc extends Bloc<NewsDetailsEvent, NewsDetailsState> {
  final TmdbApi tmdbApi;

  NewsDetailsBloc(this.tmdbApi) : super(NewsDetailsInitial()) {
    on<FetchNewsDetails>((event, emit) async {
      emit(NewsDetailsLoading());
      try {
        final newsDetails = await tmdbApi.fetchNewsDetails(event.id);
        emit(NewsDetailsLoaded(newsDetails));
      } catch (e) {
        emit(NewsDetailsError(e.toString()));
      }
    });
  }
}
