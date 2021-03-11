import 'package:equatable/equatable.dart';

abstract class TherapistEvent extends Equatable {}

class FetchTherapistsEvent extends TherapistEvent {
  final accessToken;

  FetchTherapistsEvent(this.accessToken);

  @override
  List<Object> get props => [accessToken];
}
