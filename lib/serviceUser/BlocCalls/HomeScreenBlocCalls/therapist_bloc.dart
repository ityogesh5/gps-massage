import 'package:bloc/bloc.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListsModel.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_state.dart';
import 'package:meta/meta.dart';

import 'Repository/therapist_repository.dart';


class GetTherapistBloc extends Bloc<TherapistEvent, TherapistState> {
  GetTherapistRepository getTherapistRepository;

  GetTherapistBloc({@required this.getTherapistRepository}) : super(null);

  @override
  TherapistState get initialState => IfNotSearched();

  @override
  Stream<TherapistState> mapEventToState(TherapistEvent event) async* {
    if (event is FetchTherapistsEvent) {
      yield GetTherapistLoadingState();
      try {
        List<TherapistDatum> getTherapistsUsers =
        await getTherapistRepository.getTherapistProfiles(event.accessToken);
        yield GetTherapistLoadedState(getTherapistsUsers: getTherapistsUsers);
      } catch (e) {
        yield GetTherapistErrorState(message: e.toString());
      }
    }
  }
}
