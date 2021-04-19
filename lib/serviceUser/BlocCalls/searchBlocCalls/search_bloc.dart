import 'package:bloc/bloc.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/searchBlocCalls/Repository/SearchResultsRepository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/searchBlocCalls/search_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/searchBlocCalls/search_state.dart';
import 'package:meta/meta.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  GetSearchResultsRepository getSearchResultsRepository;

  SearchBloc({@required this.getSearchResultsRepository});

  @override
  SearchState get initialState => SearchLoadingState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is FetchSearchResultsEvent) {
      yield SearchLoaderState();
      try {
        List<UserTypeList> getTherapistsUsers =
            await getSearchResultsRepository.getTherapistProfilesByType(
                event.accessToken,
                event.massageTypeValue,
                event.pageNumber,
                event.pageSize);
        yield SearchLoadedState(getTherapistsUsers: getTherapistsUsers);
      } catch (e) {
        yield SearchErrorState(message: e.toString());
      }
    } else if (event is RefreshSearchEvent) {
      yield SearchLoadingState();
    }
  }
}
