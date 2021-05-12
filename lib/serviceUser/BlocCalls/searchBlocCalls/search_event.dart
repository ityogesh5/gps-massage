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


class CallSearchByTypeEvent extends SearchEvent {
  final pageNumber;
  final pageSize;
  final searchType;

  CallSearchByTypeEvent(this.pageNumber, this.pageSize,this.searchType);

  @override
  // TODO: implement props
  List<Object> get props => [pageNumber, pageSize,searchType];
}
