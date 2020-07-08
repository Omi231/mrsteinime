import 'package:mrsteinime/bloc/genre_bloc/GenreEvent.dart';
import 'package:mrsteinime/bloc/genre_bloc/GenreState.dart';
import 'package:bloc/bloc.dart';
import 'package:mrsteinime/model/Genre.dart';
import 'package:mrsteinime/resource/AnimeResource.dart';

class GenreBloc extends Bloc<GenreEvent,GenreState>{
  AnimeRepository animeRepository;
  GenreBloc({
    this.animeRepository
  });

  @override
  // TODO: implement initialState
  GenreState get initialState => GenreUnitializedState();

  @override
  Stream<GenreState> mapEventToState(GenreEvent event)async* {
    if(event is FetchGenreEvent){
      yield GenreUnitializedState();
      try{
        List<Genre>list =await  animeRepository.getGenre();
        yield GenreLoadedState(list:list);

      }catch(e){
        yield GenreFailureState();
      }
    }
    // TODO: implement mapEventToState
  }

}