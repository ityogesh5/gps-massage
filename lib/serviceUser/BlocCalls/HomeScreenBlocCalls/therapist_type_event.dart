import 'package:equatable/equatable.dart';

abstract class TherapistTypeEvent extends Equatable {}

class FetchTherapistTypeEvent extends TherapistTypeEvent {
  final accessToken;
  final massageTypeValue;
  final pageNumber;
  final pageSize;

  FetchTherapistTypeEvent(
      this.accessToken, this.massageTypeValue, this.pageNumber, this.pageSize);

  @override
  List<Object> get props =>
      [accessToken, massageTypeValue, pageNumber, pageSize];
}

class RefreshEvent extends TherapistTypeEvent {
  final accessToken;
  final pageNumber;
  final pageSize;
  final context;

  RefreshEvent(this.accessToken, this.pageNumber, this.pageSize, this.context);

  @override
  // TODO: implement props
  List<Object> get props => [accessToken];
}

class DetailEvent extends TherapistTypeEvent {
  final accessToken;
  final userId;

  DetailEvent(this.accessToken, this.userId);

  @override
  // TODO: implement props
  List<Object> get props => [accessToken, userId];
}

class RecommendEvent extends TherapistTypeEvent {
  final accessToken;
  final pageNumber;
  final pageSize;

  RecommendEvent(this.accessToken, this.pageNumber, this.pageSize);

  @override
  // TODO: implement props
  List<Object> get props => [accessToken, pageNumber, pageSize];
}
