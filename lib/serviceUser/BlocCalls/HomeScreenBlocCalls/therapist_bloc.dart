import 'package:bloc/bloc.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_state.dart';
import 'package:meta/meta.dart';

class TherapistUsersBloc
    extends Bloc<TherapistUsersEvent, TherapistUsersState> {
  GetTherapistUsersRepository getTherapistRepository;

  TherapistUsersBloc({@required this.getTherapistRepository}) : super();

  @override
  TherapistUsersState get initialState => LoadingState();

  @override
  Stream<TherapistUsersState> mapEventToState(
      TherapistUsersEvent event) async* {
    if (event is InitialHomeEvent) {
      print('Refresh home state');
      yield LoadingState();
      try {
        List<TherapistDatum> getTherapistsUsers = await getTherapistRepository
            .getTherapistUsersProfiles(event.accessToken);
        yield GetTherapistUsersState(getTherapistsUsers: getTherapistsUsers);
      } catch (e) {
        yield GetTherapistUsersErrorState(message: e.toString());
      }
    }
  }
}
