import 'package:equatable/equatable.dart';

abstract class TherapistTypeEvent extends Equatable {}

class FetchTherapistsEvent extends TherapistTypeEvent {
  final accessToken;
  final massageTypeValue;

  FetchTherapistsEvent(this.accessToken, this.massageTypeValue);

  @override
  List<Object> get props => [accessToken, massageTypeValue];
}
