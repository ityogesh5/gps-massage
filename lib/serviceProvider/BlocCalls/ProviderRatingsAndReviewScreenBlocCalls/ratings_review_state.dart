import 'package:equatable/equatable.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/providerReviewandRatingsViewResponseModel.dart';
import 'package:meta/meta.dart';

abstract class TherapistReviewState extends Equatable {}

class GetTherapistReviewLoadingState extends TherapistReviewState {
  @override
  List<Object> get props => null;
}

class GetTherapistReviewLoaderState extends TherapistReviewState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetTherapistReviewLoadedState extends TherapistReviewState {
  List<TherapistReviewList> getTherapistsUsers;

  GetTherapistReviewLoadedState({@required this.getTherapistsUsers});

  @override
  List<Object> get props => [getTherapistsUsers];
}

// ignore: must_be_immutable
class GetTherapistReviewErrorState extends TherapistReviewState {
  String message;

  GetTherapistReviewErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
