import 'package:bloc/bloc.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/userReviewandRatingsResponseModel.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/GetUserRatingsandReviewScreenBlocCalls/user_ratings_event.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/GetUserRatingsandReviewScreenBlocCalls/user_ratings_state.dart';
import 'package:meta/meta.dart';

import 'Repository/user_ratings_review_repository.dart';

class UserReviewBloc extends Bloc<UserReviewEvent, UserReviewState> {
  GetUserReviewRepository getUserReviewRepository;

  UserReviewBloc({@required this.getUserReviewRepository});

  @override
  UserReviewState get initialState => GetUserReviewLoadingState();

  @override
  Stream<UserReviewState> mapEventToState(UserReviewEvent event) async* {
    if (event is FetchUserReviewEvent) {
      yield GetUserReviewLoaderState();
      try {
        List<UserReviewList> getUsersRatings =
            await getUserReviewRepository.getUserReviewById(event.accessToken,
                event.userId, event.pageNumber, event.pageSize);
        yield GetUserReviewLoadedState(getUsersRatings: getUsersRatings);
      } catch (e) {
        yield GetUserReviewErrorState(message: e.toString());
      }
    } else if (event is RefreshEvent) {
      yield GetUserReviewLoadingState();
    }
  }
}
