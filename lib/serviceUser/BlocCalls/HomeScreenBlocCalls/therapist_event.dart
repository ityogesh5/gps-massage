import 'package:equatable/equatable.dart';

abstract class TherapistUsersEvent extends Equatable {}


class InitialHomeEvent extends TherapistUsersEvent {
  final accessToken;

  InitialHomeEvent(this.accessToken);

  @override
  // TODO: implement props
  List<Object> get props => [accessToken];
}
