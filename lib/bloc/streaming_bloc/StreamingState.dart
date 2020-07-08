import 'package:equatable/equatable.dart';
import 'package:mrsteinime/model/Episode.dart';

abstract class StreamingState extends Equatable{}


class StreamingLoadedState extends StreamingState{
  String video_url;
  List<Episode>episode;
  String judul_anime;
  StreamingLoadedState({
    this.video_url,
    this.judul_anime,
    this.episode
  });

  @override
  // TODO: implement props
  List<Object> get props => [video_url,episode,judul_anime];
}


class StreamingFailureState extends StreamingState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}


class StreamingUnitializedState extends StreamingState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}