import 'package:equatable/equatable.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/userReviewandRatingsResponseModel.dart';
import 'package:meta/meta.dart';

abstract class UserReviewState extends Equatable {}

class GetUserReviewLoadingState extends UserReviewState {
  @override
  List<Object> get props => null;
}

class GetUserReviewLoaderState extends UserReviewState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetUserReviewLoadedState extends UserReviewState {
  List<UserReviewList> getUsersRatings;

  GetUserReviewLoadedState({@required this.getUsersRatings});

  @override
  List<Object> get props => [getUsersRatings];
}

// ignore: must_be_immutable
class GetUserReviewErrorState extends UserReviewState {
  String message;

  GetUserReviewErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
