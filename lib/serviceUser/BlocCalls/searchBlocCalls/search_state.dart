import 'package:equatable/equatable.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/searchModels/SearchTherapistResultsModel.dart';
import 'package:meta/meta.dart';

abstract class SearchState extends Equatable {}

class SearchLoadingState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaderState extends SearchState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SearchLoadedState extends SearchState {
  List<SearchList> getTherapistsSearchResults;

  SearchLoadedState({@required this.getTherapistsSearchResults});

  @override
  List<Object> get props => [getTherapistsSearchResults];
}

// ignore: must_be_immutable
class SearchSortByDataLoadedState extends SearchState {
  List<SearchList> getTherapistsSearchResults;

  SearchSortByDataLoadedState({@required this.getTherapistsSearchResults});

  @override
  List<Object> get props => [getTherapistsSearchResults];
}

// ignore: must_be_immutable
class SearchErrorState extends SearchState {
  String message;

  SearchErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
