import 'package:equatable/equatable.dart';
import 'package:mrsteinime/model/DetailAnime.dart';
import 'package:mrsteinime/model/RecommendedAnime.dart';

abstract class DetailState extends Equatable{}


class DetailLoadedState extends DetailState{
  DetailAnime detail;
  List<RecommendedAnime>list;
  DetailLoadedState({
    this.detail,
    this.list
  });

  @override
  // TODO: implement props
  List<Object> get props => [detail,list];
}


class DetailFailureState extends DetailState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}


class DetailUnitializedState extends DetailState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}