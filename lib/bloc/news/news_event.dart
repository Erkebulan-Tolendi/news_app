import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNews extends NewsEvent {
  final int page;

  const FetchNews(this.page);

  @override
  List<Object> get props => [page];
}
