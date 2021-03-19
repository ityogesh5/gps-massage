import 'package:equatable/equatable.dart';

abstract class TherapistTypeEvent extends Equatable {}

class FetchTherapistTypeEvent extends TherapistTypeEvent {
  final accessToken;
  final massageTypeValue;

  FetchTherapistTypeEvent(this.accessToken, this.massageTypeValue);

  @override
  List<Object> get props => [accessToken, massageTypeValue];
}

class RefreshEvent extends TherapistTypeEvent{
  final accessToken;
  RefreshEvent(this.accessToken);
  @override
  // TODO: implement props
  List<Object> get props => [accessToken];

}
