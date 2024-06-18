import 'package:equatable/equatable.dart';

abstract class NewsDetailsState extends Equatable {
  const NewsDetailsState();

  @override
  List<Object> get props => [];
}

class NewsDetailsInitial extends NewsDetailsState {}

class NewsDetailsLoading extends NewsDetailsState {}

class NewsDetailsLoaded extends NewsDetailsState {
  final Map<String, dynamic> news;

  const NewsDetailsLoaded(this.news);

  @override
  List<Object> get props => [news];
}

class NewsDetailsError extends NewsDetailsState {
  final String message;

  const NewsDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
