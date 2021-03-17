import 'package:equatable/equatable.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:meta/meta.dart';

abstract class TherapistTypeState extends Equatable {}


class GetTherapistLoadingState extends TherapistTypeState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetTherapistLoadedState extends TherapistTypeState {
  List<UserList> getTherapistsUsers;

  GetTherapistLoadedState({@required this.getTherapistsUsers});

  @override
  List<Object> get props => [getTherapistsUsers];
}

// ignore: must_be_immutable
class GetTherapistErrorState extends TherapistTypeState {
  String message;

  GetTherapistErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
