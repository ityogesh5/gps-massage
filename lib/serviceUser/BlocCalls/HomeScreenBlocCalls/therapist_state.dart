import 'package:equatable/equatable.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListsModel.dart';
import 'package:meta/meta.dart';

abstract class TherapistState extends Equatable {}

class IfNotSearched extends TherapistState {
  @override
  List<Object> get props => null;
}

class GetTherapistInitialState extends TherapistState {
  @override
  List<Object> get props => [];
}

class GetTherapistLoadingState extends TherapistState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetTherapistLoadedState extends TherapistState {
  List<TherapistDatum> getTherapistsUsers;

  GetTherapistLoadedState({@required this.getTherapistsUsers});

  @override
  List<Object> get props => [ListOfTherapistModel];
}

// ignore: must_be_immutable
class GetTherapistErrorState extends TherapistState {
  String message;

  GetTherapistErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
