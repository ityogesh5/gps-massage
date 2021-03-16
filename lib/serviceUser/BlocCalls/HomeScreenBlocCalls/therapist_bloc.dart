import 'package:bloc/bloc.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_state.dart';
import 'package:meta/meta.dart';



class TherapistBloc extends Bloc<TherapistEvent, TherapistState> {
  GetTherapistRepository getTherapistRepository;

  TherapistBloc({@required this.getTherapistRepository}) : super();

  @override
  TherapistState get initialState => GetTherapistInitialState();

  @override
  Stream<TherapistState> mapEventToState(TherapistEvent event) async* {
    if (event is FetchTherapistsEvent) {
      yield GetTherapistLoadingState();
      try {
        List<UserList> getTherapistsUsers =
        await getTherapistRepository.getTherapistProfiles(event.accessToken,event.massageTypeValue);
        yield GetTherapistLoadedState(getTherapistsUsers: getTherapistsUsers);
      } catch (e) {
        yield GetTherapistErrorState(message: e.toString());
      }
    }
  }
}
