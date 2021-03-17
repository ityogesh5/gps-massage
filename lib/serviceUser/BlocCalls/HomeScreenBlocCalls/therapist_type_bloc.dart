import 'package:bloc/bloc.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_type_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_state.dart';
import 'package:meta/meta.dart';

class TherapistTypeBloc extends Bloc<TherapistTypeEvent, TherapistTypeState> {
  GetTherapistTypeRepository getTherapistTypeRepository;

  TherapistTypeBloc({@required this.getTherapistTypeRepository}) : super();

  @override
  TherapistTypeState get initialState => GetTherapistLoadingState();

  @override
  Stream<TherapistTypeState> mapEventToState(TherapistTypeEvent event) async* {
    if (event is FetchTherapistsEvent) {
      yield GetTherapistLoadingState();
      try {
        List<UserList> getTherapistsUsers =
            await getTherapistTypeRepository.getTherapistProfilesByType(
                event.accessToken, event.massageTypeValue);
        yield GetTherapistLoadedState(getTherapistsUsers: getTherapistsUsers);
      } catch (e) {
        yield GetTherapistErrorState(message: e.toString());
      }
    }
  }
}
