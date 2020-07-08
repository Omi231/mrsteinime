import 'package:mrsteinime/bloc/genre_result_bloc/GenreResultEvent.dart';
import 'package:mrsteinime/bloc/genre_result_bloc/GenreResultState.dart';
import 'package:bloc/bloc.dart';
import 'package:mrsteinime/model/AnimeGenreResult.dart';
import 'package:mrsteinime/resource/AnimeResource.dart';

class GenreResultBloc extends Bloc<GenreResultEvent,GenreResultState>{
  AnimeRepository animeRepository;
  GenreResultBloc({
    this.animeRepository
  });

  @override
  // TODO: implement initialState
  GenreResultState get initialState => GenreResultUnitializedState();

  @override
  Stream<GenreResultState> mapEventToState(GenreResultEvent event)async *{
    print(event.toString());
    if(event is FetchGenreResultEvent){
          print(event.url);
      if(state is GenreResultUnitializedState){
        try{
          List<AnimeGenreResult>list= await animeRepository.getGenreResult(event.url,2);
          if(list.length<12){
            yield GenreResultLoadedState(hasReachMax: true,page: 2,list: list);
          }else{
            yield GenreResultLoadedState(hasReachMax: false,page: 2,list: list);
          }
        }catch(e){
            print("hellos treik"+e.toString());
           yield GenreResultFailureState();
        }
      }else{
        print(event.url);
        GenreResultLoadedState genreResultLoadedState=state as GenreResultLoadedState;
        List<AnimeGenreResult>list= await animeRepository.getGenreResult(event.url,genreResultLoadedState.page);
        yield (list.isEmpty)?genreResultLoadedState.copyWith(hasReachMax: true):
        genreResultLoadedState.copyWith(
          list: genreResultLoadedState.list+list,
          hasReachMax: false
          ,page: genreResultLoadedState.page+1
        );

      }
    }else if(event is ResetGenreResultEvent){
      yield GenreResultUnitializedState();
    }
  }

  bool hasReachMax(GenreResultLoadedState state){
    return state is GenreResultLoadedState && state.hasReachMax;
  }

}