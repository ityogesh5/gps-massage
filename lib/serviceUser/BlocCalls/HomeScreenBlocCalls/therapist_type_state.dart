import 'package:equatable/equatable.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:meta/meta.dart';

abstract class TherapistTypeState extends Equatable {}


class GetTherapistTypeLoaderState extends TherapistTypeState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetTherapistLoadedState extends TherapistTypeState {
  List<InitialTherapistData> getTherapistsUsers;

  GetTherapistLoadedState({@required this.getTherapistsUsers});

  @override
  List<Object> get props => [getTherapistsUsers];
}
// ignore: must_be_immutable
class GetTherapistTypeLoadedState extends TherapistTypeState {
  List<TypeTherapistData> getTherapistsUsers;

  GetTherapistTypeLoadedState({@required this.getTherapistsUsers});

  @override
  List<Object> get props => [getTherapistsUsers];
}

// ignore: must_be_immutable
class GetTherapistTypeErrorState extends TherapistTypeState {
  String message;

  GetTherapistTypeErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
