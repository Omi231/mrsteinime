import 'package:equatable/equatable.dart';
import 'package:mrsteinime/model/RecommendedAnime.dart';

abstract class RecommendedState extends Equatable{}


class RecommendedLoadedState extends RecommendedState{
  List<RecommendedAnime>list;
  RecommendedLoadedState({
    this.list
  });

  @override
  // TODO: implement props
  List<Object> get props => [list];
}


class RecommendedFailureState extends RecommendedState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}


class RecommendedUnitializedState extends RecommendedState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}