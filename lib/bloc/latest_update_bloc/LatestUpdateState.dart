import 'package:equatable/equatable.dart';
import 'package:mrsteinime/model/LatestUpdateAnime.dart';

abstract class LatestUpdateState extends Equatable{}

class LatestUpdateUnitializedState extends LatestUpdateState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class LatestUpdateFailureState extends LatestUpdateState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}


class LatestUpdateLoadedState extends LatestUpdateState{
  List<LatestUpdateAnime>list;
  int page=1;
  bool hasReachMax=false;

  LatestUpdateLoadedState({
    this.list,
    this.hasReachMax,
    this.page
  });

  LatestUpdateLoadedState copyWith({List<LatestUpdateAnime>list,int page,bool hasReachMax}){
    return LatestUpdateLoadedState(
      hasReachMax: hasReachMax ?? this.hasReachMax,
      page: page ?? this.page,
      list: list ?? this.list
    );
  }


  @override
  List<Object> get props => [list,page,hasReachMax];
  
}