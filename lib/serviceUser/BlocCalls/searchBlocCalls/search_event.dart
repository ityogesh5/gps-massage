import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class FetchSearchResultsEvent extends SearchEvent {
  final accessToken;
  final massageTypeValue;
  final pageNumber;
  final pageSize;

  FetchSearchResultsEvent(
      this.accessToken, this.massageTypeValue, this.pageNumber, this.pageSize);

  @override
  List<Object> get props =>
      [accessToken, massageTypeValue, pageNumber, pageSize];
}

class RefreshSearchEvent extends SearchEvent {
  final accessToken;

  RefreshSearchEvent(this.accessToken);

  @override
  // TODO: implement props
  List<Object> get props => [accessToken];
}
