import 'package:equatable/equatable.dart';

abstract class TherapistTypeEvent extends Equatable {}

class FetchTherapistTypeEvent extends TherapistTypeEvent {
  final accessToken;
  final massageTypeValue;
  final pageNumber;
  final pageSize;

  FetchTherapistTypeEvent(this.accessToken, this.massageTypeValue,this.pageNumber,this.pageSize);

  @override
  List<Object> get props => [accessToken, massageTypeValue,pageNumber,pageSize];
}

class RefreshEvent extends TherapistTypeEvent {
  final accessToken;

  RefreshEvent(this.accessToken);

  @override
  // TODO: implement props
  List<Object> get props => [accessToken];
}
