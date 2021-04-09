import 'package:bloc/bloc.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/providerReviewandRatingsViewResponseModel.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/ProviderRatingsAndReviewScreenBlocCalls/Repository/ratings_review_repository.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/ProviderRatingsAndReviewScreenBlocCalls/ratings_review_event.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/ProviderRatingsAndReviewScreenBlocCalls/ratings_review_state.dart';
import 'package:meta/meta.dart';

class TherapistReviewBloc extends Bloc<TherapistReviewEvent, TherapistReviewState> {
  GetTherapistReviewRepository getTherapistReviewRepository;

  TherapistReviewBloc({@required this.getTherapistReviewRepository});

  @override
  TherapistReviewState get initialState => GetTherapistReviewLoadingState();

  @override
  Stream<TherapistReviewState> mapEventToState(TherapistReviewEvent event) async* {
    if (event is FetchTherapistReviewEvent) {
      yield GetTherapistReviewLoadingState();
      try {
        List<UserList> getTherapistsUsers =
            await getTherapistReviewRepository.getTherapistReviewById(
                event.accessToken,
                event.therapistId,
                event.pageNumber,
                event.pageSize);
        yield GetTherapistReviewLoadedState(
            getTherapistsUsers: getTherapistsUsers);
      } catch (e) {
        yield GetTherapistReviewErrorState(message: e.toString());
      }
    } else if (event is RefreshEvent) {
      yield GetTherapistReviewLoadingState();
    }
  }
}
