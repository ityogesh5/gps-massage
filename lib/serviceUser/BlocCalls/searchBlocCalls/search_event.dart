import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class FetchSearchResultsEvent extends SearchEvent {
  final pageNumber;
  final pageSize;

  FetchSearchResultsEvent(this.pageNumber, this.pageSize);

  @override
  List<Object> get props =>
      [pageNumber, pageSize];
}

class CallSearchEvent extends SearchEvent {
  final pageNumber;
  final pageSize;

  CallSearchEvent(this.pageNumber, this.pageSize);

  @override
  // TODO: implement props
  List<Object> get props => [pageNumber, pageSize];
}
