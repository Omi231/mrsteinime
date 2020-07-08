import 'dart:convert';

import 'package:mrsteinime/bloc/streaming_bloc/StreamingEvent.dart';
import 'package:mrsteinime/bloc/streaming_bloc/StreamingState.dart';
import 'package:bloc/bloc.dart';
import 'package:mrsteinime/model/Episode.dart';
import 'package:mrsteinime/resource/AnimeResource.dart';

class StreamingBloc extends Bloc<StreamingEvent,StreamingState>{
  AnimeRepository animeRepository;
  StreamingBloc({
    this.animeRepository
  });

  @override
  // TODO: implement initialState
  StreamingState get initialState => StreamingUnitializedState();

  @override
  Stream<StreamingState> mapEventToState(StreamingEvent event)async* {
    if(event is FetchStreamingEvent){
      yield StreamingUnitializedState();
      try{
        String result =await  animeRepository.getStreaming(event.url);
        var result_json=json.decode(result);
        String video_url=result_json["data"]["video_url"].toString();
        List<Episode>list=listEpisodeFromJson(result_json["data"]["episode"]);
        String judul_anime=result_json["data"]["judul_anime"];
        yield StreamingLoadedState(video_url: video_url,episode:list,judul_anime: judul_anime);
      }catch(e){
        yield StreamingFailureState();
      }
    }
    // TODO: implement mapEventToState
  }

}