import 'package:bloc/bloc.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_type_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_state.dart';
import 'package:meta/meta.dart';

class TherapistTypeBloc extends Bloc<TherapistTypeEvent, TherapistTypeState> {
  GetTherapistTypeRepository getTherapistTypeRepository;

  TherapistTypeBloc({@required this.getTherapistTypeRepository});

  @override
  TherapistTypeState get initialState => GetTherapistTypeLoadingState();

  @override
  Stream<TherapistTypeState> mapEventToState(TherapistTypeEvent event) async* {
    if (event is FetchTherapistTypeEvent) {
      yield GetTherapistTypeLoaderState();
      try {
        List<UserList> getTherapistsUsers =
            await getTherapistTypeRepository.getTherapistProfilesByType(
                event.accessToken, event.massageTypeValue);
        yield GetTherapistTypeLoadedState(
            getTherapistsUsers: getTherapistsUsers);
      } catch (e) {
        yield GetTherapistTypeErrorState(message: e.toString());
      }
    } else if (event is RefreshEvent) {
      yield GetTherapistTypeLoadingState();
    }
  }
}
