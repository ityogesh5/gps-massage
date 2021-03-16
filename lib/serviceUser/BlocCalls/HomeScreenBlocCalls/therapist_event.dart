import 'package:equatable/equatable.dart';

abstract class TherapistEvent extends Equatable {}

class FetchTherapistsEvent extends TherapistEvent {
  final accessToken;
  final massageTypeValue;

  FetchTherapistsEvent(this.accessToken,this.massageTypeValue);

  @override
  List<Object> get props => [accessToken,massageTypeValue];
}
