import 'package:equatable/equatable.dart';

abstract class TherapistReviewEvent extends Equatable {}

class FetchTherapistReviewEvent extends TherapistReviewEvent {
  final accessToken;
  final therapistId;
  final pageNumber;
  final pageSize;

  FetchTherapistReviewEvent(
      this.accessToken, this.therapistId, this.pageNumber, this.pageSize);

  @override
  List<Object> get props => [accessToken, therapistId, pageNumber, pageSize];
}

class RefreshEvent extends TherapistReviewEvent {
  final accessToken;

  RefreshEvent(this.accessToken);

  @override
  // TODO: implement props
  List<Object> get props => [accessToken];
}
