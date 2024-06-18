import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/tmdb_api.dart';
import 'package:news_app/bloc/news_details/news_details_bloc.dart';
import 'package:news_app/bloc/news_details/news_details_event.dart';
import 'package:news_app/bloc/news_details/news_details_state.dart';

class NewsDetailsPage extends StatelessWidget {
  final int newsId;

  const NewsDetailsPage({Key? key, required this.newsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsDetailsBloc(TmdbApi())..add(FetchNewsDetails(newsId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('News Details'),
        ),
        body: BlocBuilder<NewsDetailsBloc, NewsDetailsState>(
          builder: (context, state) {
            if (state is NewsDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NewsDetailsLoaded) {
              final news = state.news;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        if (news['poster_path'] != null)
                          Image.network(
                            'https://image.tmdb.org/t/p/w500${news['poster_path']}',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        Positioned(
                          top: 8.0,
                          left: 8.0,
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              news['vote_average']?.toString() ?? 'N/A',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8.0,
                          right: 8.0,
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 30.0,
                          ),
                        ),
                        Positioned(
                          bottom: 8.0,
                          left: 8.0,
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news['title'] ?? 'No Title',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  news['release_date'] ?? 'No Date',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        news['overview'] ?? 'No Description',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is NewsDetailsError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No details available.'));
            }
          },
        ),
      ),
    );
  }
}
