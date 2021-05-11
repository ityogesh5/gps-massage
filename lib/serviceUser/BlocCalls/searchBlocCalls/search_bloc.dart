import 'package:bloc/bloc.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/searchModels/SearchTherapistResultsModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/searchModels/SearchTherapistByTypeModel.dart';
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
        List<SearchList> getTherapistsSearchResults =
            await getSearchResultsRepository.getSearchResultsByType(
                event.pageNumber, event.pageSize);
        yield SearchLoadedState(
            getTherapistsSearchResults: getTherapistsSearchResults);
      } catch (e) {
        yield SearchErrorState(message: e.toString());
      }
    } else if (event is CallSearchByTypeEvent) {
      yield SearchLoadingState();
      try {
        List<SearchTherapistTypeList> getTherapistsSearchResults =
            await getSearchResultsRepository.getSearchResultsBySortType(
                event.pageNumber, event.pageSize, event.searchType);
        yield SearchSortByDataLoadedState(
            getTherapistsSearchResults: getTherapistsSearchResults);
      } catch (e) {
        yield SearchErrorState(message: e.toString());
      }
    }
  }
}
