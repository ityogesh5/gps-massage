import 'package:equatable/equatable.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:meta/meta.dart';

abstract class SearchState extends Equatable {}

class SearchLoadingState extends SearchState {
  @override
  List<Object> get props => null;
}

class SearchLoaderState extends SearchState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SearchLoadedState extends SearchState {
  List<TypeTherapistData> getTherapistsUsers;

  SearchLoadedState({@required this.getTherapistsUsers});

  @override
  List<Object> get props => [getTherapistsUsers];
}

// ignore: must_be_immutable
class SearchErrorState extends SearchState {
  String message;

  SearchErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
