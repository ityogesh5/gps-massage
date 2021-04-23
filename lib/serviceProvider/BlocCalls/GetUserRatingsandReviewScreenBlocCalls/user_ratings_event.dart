import 'package:equatable/equatable.dart';

abstract class UserReviewEvent extends Equatable {}

class FetchUserReviewEvent extends UserReviewEvent {
  final accessToken;
  final userId;
  final pageNumber;
  final pageSize;

  FetchUserReviewEvent(
      this.accessToken, this.userId, this.pageNumber, this.pageSize);

  @override
  List<Object> get props => [accessToken, userId, pageNumber, pageSize];
}

class RefreshEvent extends UserReviewEvent {
  final accessToken;

  RefreshEvent(this.accessToken);

  @override
  // TODO: implement props
  List<Object> get props => [accessToken];
}
