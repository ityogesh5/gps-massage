import 'package:equatable/equatable.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:meta/meta.dart';

abstract class TherapistState extends Equatable {}


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
  List<UserList> getTherapistsUsers;

  GetTherapistLoadedState({@required this.getTherapistsUsers});

  @override
  List<Object> get props => [getTherapistsUsers];
}

// ignore: must_be_immutable
class GetTherapistErrorState extends TherapistState {
  String message;

  GetTherapistErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
