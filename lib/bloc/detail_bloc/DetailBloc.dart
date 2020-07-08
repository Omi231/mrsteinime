import 'dart:convert';

import 'package:mrsteinime/bloc/detail_bloc/DetailEvent.dart';
import 'package:mrsteinime/bloc/detail_bloc/DetailState.dart';
import 'package:bloc/bloc.dart';
import 'package:mrsteinime/model/DetailAnime.dart';
import 'package:mrsteinime/model/RecommendedAnime.dart';
import 'package:mrsteinime/resource/AnimeResource.dart';

class DetailBloc extends Bloc<DetailEvent,DetailState>{
  AnimeRepository animeRepository;
  DetailBloc({
    this.animeRepository
  });

  @override
  // TODO: implement initialState
  DetailState get initialState => DetailUnitializedState();

  @override
  Stream<DetailState> mapEventToState(DetailEvent event)async* {
    if(event is FetchDetailEvent){
      yield DetailUnitializedState();
      try{
        print("Oke so 2");
        String result=await  animeRepository.getDetail(event.url);
        var json_data=json.decode(result);
        DetailAnime detail = detailAnimeFromJson(result);
        print("helloos"+detail.toString());
        List<RecommendedAnime>list=listRecommendedFromJson2(json_data["data"]["rekomendasi"]);
        print("Oke so");
        yield DetailLoadedState(detail:detail,list: list);

      }catch(e){
        print(e.toString());
        yield DetailFailureState();
      }
    }
    // TODO: implement mapEventToState
  }

}