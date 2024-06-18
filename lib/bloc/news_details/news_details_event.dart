import 'package:equatable/equatable.dart';

abstract class NewsDetailsEvent extends Equatable {
  const NewsDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchNewsDetails extends NewsDetailsEvent {
  final int id;

  const FetchNewsDetails(this.id);

  @override
  List<Object> get props => [id];
}
