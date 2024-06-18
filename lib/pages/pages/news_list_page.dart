import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news/news_bloc.dart';
import 'package:news_app/bloc/news/news_event.dart';
import 'package:news_app/bloc/news/news_state.dart';

import 'news_details_page.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(FetchNews(_page));

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          _page++;
          BlocProvider.of<NewsBloc>(context).add(FetchNews(_page));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading && _page == 1) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                _page = 1;
                BlocProvider.of<NewsBloc>(context).add(FetchNews(_page));
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  final news = state.news[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NewsItem(news: news),
                  );
                },
              ),
            );
          } else if (state is NewsError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No news available.'));
          }
        },
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final Map<String, dynamic> news;

  const NewsItem({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsPage(newsId: news['id']),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: news['poster_path'] != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500${news['poster_path']}',
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/placeholder.png',
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
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
                    size: 24.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              news['title'] ?? 'No Title',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              news['release_date'] ?? 'No Date',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
