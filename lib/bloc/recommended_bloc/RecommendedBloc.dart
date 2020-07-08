import 'package:mrsteinime/bloc/recommended_bloc/RecommendedEvent.dart';
import 'package:mrsteinime/bloc/recommended_bloc/RecommendedState.dart';
import 'package:bloc/bloc.dart';
import 'package:mrsteinime/model/RecommendedAnime.dart';
import 'package:mrsteinime/resource/AnimeResource.dart';

class RecommendedBloc extends Bloc<RecommendedEvent,RecommendedState>{
  AnimeRepository animeRepository;
  RecommendedBloc({
    this.animeRepository
  });

  @override
  // TODO: implement initialState
  RecommendedState get initialState => RecommendedUnitializedState();

  @override
  Stream<RecommendedState> mapEventToState(RecommendedEvent event)async* {
    if(event is FetchRecommendedEvent){
      yield RecommendedUnitializedState();
      try{
        List<RecommendedAnime>list =await  animeRepository.getRecommended();
        yield RecommendedLoadedState(list:list);

      }catch(e){
        yield RecommendedFailureState();
      }
    }
    // TODO: implement mapEventToState
  }

}