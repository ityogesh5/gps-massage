import 'package:bloc/bloc.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_type_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_state.dart';

import 'package:meta/meta.dart';

class TherapistTypeBloc extends Bloc<TherapistTypeEvent, TherapistTypeState> {
  GetTherapistTypeRepository getTherapistTypeRepository;

  TherapistTypeBloc({@required this.getTherapistTypeRepository});

  @override
  TherapistTypeState get initialState => GetTherapistTypeLoaderState();

  @override
  Stream<TherapistTypeState> mapEventToState(TherapistTypeEvent event) async* {
    if (event is FetchTherapistTypeEvent) {
      yield GetTherapistTypeLoaderState();
      try {
        List<UserList> getTherapistsUsers =
        await getTherapistTypeRepository.getTherapistProfilesByType(
            event.accessToken,
            event.massageTypeValue,
            event.pageNumber,
            event.pageSize);
        List<UserList> getRecommendedTherapists =
        await getTherapistTypeRepository.getRecommendedTherapists(
            event.accessToken, event.pageNumber, event.pageSize);
        yield GetTherapistTypeLoadedState(
            getTherapistsUsers: getTherapistsUsers,
            getRecommendedTherapists: getRecommendedTherapists);
      } catch (e) {
        yield GetTherapistTypeErrorState(message: e.toString());
      }
    } else if (event is RefreshEvent) {
      yield GetTherapistTypeLoaderState();
      try {
        List<UserList> getTherapistsUsers =
        await getTherapistTypeRepository.getTherapistProfiles(
            event.accessToken, event.pageNumber, event.pageSize);
        List<UserList> getRecommendedTherapists =
        await getTherapistTypeRepository.getRecommendedTherapists(
            event.accessToken, event.pageNumber, event.pageSize);
        yield GetTherapistLoadedState(
            getTherapistsUsers: getTherapistsUsers,
            getRecommendedTherapists: getRecommendedTherapists);
      } catch (e) {
        yield GetTherapistTypeErrorState(message: e.toString());
      }
    } else if (event is DetailEvent) {
      yield GetTherapistTypeLoaderState();
      try {
        TherapistByIdModel getTherapistByIdModel =
        await getTherapistTypeRepository.getTherapistById(
            event.accessToken, event.userId);
        yield GetTherapistId(getTherapistByIdModel: getTherapistByIdModel);
      } catch (e) {
        yield GetTherapistTypeErrorState(message: e.toString());
      }
    } else if (event is RecommendEvent) {
      yield GetTherapistTypeLoaderState();
      try {
        List<UserList> getRecommendedTherapists =
        await getTherapistTypeRepository.getRecommendedTherapists(
            event.accessToken, event.pageNumber, event.pageSize);
        yield GetRecommendTherapistLoadedState(
            getRecommendedTherapists: getRecommendedTherapists);
      } catch (e) {
        yield GetTherapistTypeErrorState(message: e.toString());
      }
    }
  }
}
