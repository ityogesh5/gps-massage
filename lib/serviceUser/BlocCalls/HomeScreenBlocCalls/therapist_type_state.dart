import 'package:equatable/equatable.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:meta/meta.dart';

abstract class TherapistTypeState extends Equatable {}

class GetTherapistTypeLoadingState extends TherapistTypeState {
  @override
  List<Object> get props => null;
}

class GetTherapistTypeLoaderState extends TherapistTypeState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetTherapistLoadedState extends TherapistTypeState {
  List<UserList> getTherapistsUsers;
  List<UserList> getRecommendedTherapists;

  GetTherapistLoadedState(
      {@required this.getTherapistsUsers,
      @required this.getRecommendedTherapists});

  @override
  List<Object> get props => [getTherapistsUsers];
}

// ignore: must_be_immutable
class GetRecommendTherapistLoadedState extends TherapistTypeState {
  List<UserList> getRecommendedTherapists;

  GetRecommendTherapistLoadedState({@required this.getRecommendedTherapists});

  @override
  List<Object> get props => [getRecommendedTherapists];
}

// ignore: must_be_immutable
class GetTherapistTypeLoadedState extends TherapistTypeState {
  List<UserList> getTherapistsUsers;
  List<UserList> getRecommendedTherapists;

  GetTherapistTypeLoadedState(
      {@required this.getTherapistsUsers,
      @required this.getRecommendedTherapists});

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

class GetTherapistId extends TherapistTypeState {
  TherapistByIdModel getTherapistByIdModel;

  GetTherapistId({@required this.getTherapistByIdModel});

  @override
  // TODO: implement props
  List<Object> get props => [getTherapistByIdModel];
}
