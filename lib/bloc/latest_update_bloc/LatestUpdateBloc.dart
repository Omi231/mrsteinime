import 'package:mrsteinime/bloc/latest_update_bloc/LatestUpdateEvent.dart';
import 'package:mrsteinime/bloc/latest_update_bloc/LatestUpdateState.dart';
import 'package:bloc/bloc.dart';
import 'package:mrsteinime/model/LatestUpdateAnime.dart';
import 'package:mrsteinime/resource/AnimeResource.dart';

class LatestUpdateBloc extends Bloc<LatestUpdateEvent,LatestUpdateState>{
  AnimeRepository animeRepository;
  LatestUpdateBloc({
    this.animeRepository
  });

  @override
  // TODO: implement initialState
  LatestUpdateState get initialState => LatestUpdateUnitializedState();

  @override
  Stream<LatestUpdateState> mapEventToState(LatestUpdateEvent event)async *{
          print(event.toString());

    if(event is FetchLatestUpdateEvent){
      print(event.toString());
      if(state is LatestUpdateUnitializedState){
        try{
          List<LatestUpdateAnime>list= await animeRepository.getLatestUpdate(1);
          if(list.length<12){
            yield LatestUpdateLoadedState(hasReachMax: true,page: 2,list: list);
          }else if(list.length>=12){
            yield LatestUpdateLoadedState(hasReachMax: false,page: 2,list: list);
          }
        }catch(e){
           print(e.toString());
           yield LatestUpdateFailureState();
        }
      }else{
        LatestUpdateLoadedState latestUpdateLoadedState=state as LatestUpdateLoadedState;
        List<LatestUpdateAnime>list= await animeRepository.getLatestUpdate(latestUpdateLoadedState.page);
        yield (list.isEmpty)?latestUpdateLoadedState.copyWith(hasReachMax: true):
        latestUpdateLoadedState.copyWith(
          list: latestUpdateLoadedState.list+list,
          hasReachMax: false
          ,page: latestUpdateLoadedState.page
        );

      }
    }else if(event is ResetLatestUpdateEvent){
      yield LatestUpdateUnitializedState();
    }
  }

  bool hasReachMax(LatestUpdateLoadedState state){
    return state is LatestUpdateLoadedState && state.hasReachMax;
  }

}