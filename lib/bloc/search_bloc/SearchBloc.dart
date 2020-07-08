import 'package:mrsteinime/bloc/search_bloc/SearchEvent.dart';
import 'package:mrsteinime/bloc/search_bloc/SearchState.dart';
import 'package:bloc/bloc.dart';
import 'package:mrsteinime/model/SearchAnime.dart';
import 'package:mrsteinime/resource/AnimeResource.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  AnimeRepository animeRepository;
  SearchBloc({
    this.animeRepository
  });

  @override
  // TODO: implement initialState
  SearchState get initialState => SearchUnitializedState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event)async* {
    if(event is FetchSearchEvent){
      yield SearchLoadingState();
      try{
        List<SearchAnime>list =await  animeRepository.search(event.keyword);
        yield SearchLoadedState(list:list);
      }catch(e){
        yield SearchFailureState();
      }
    }else if(event is ResetSearchEvent){
      yield SearchUnitializedState();
    }
    // TODO: implement mapEventToState
  }

}